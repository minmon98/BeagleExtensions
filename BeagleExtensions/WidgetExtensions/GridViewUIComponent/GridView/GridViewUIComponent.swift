//
//  GridViewUIComponent.swift
//  DemoBeagleApp
//
//  Created by VTN-MINHPV21 on 26/04/2021.
//

import Foundation
import UIKit
import Beagle

class GridViewUIComponent: UIView {
    @IBOutlet var containView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    private var template: ServerDrivenComponent?
    private var spanCount = 2
    private var direction: ListView.Direction = .vertical
    enum Constants {
        static let spacing = 10
    }
    private var gridView: GridView?
    private var fixHeight: CGFloat = 100.0
    private var fixWidth: CGFloat = 100.0
    private var controller: BeagleController?
    private var dataSource: [DynamicObject]? {
        didSet {
            self.collectionView.reloadData()
            self.collectionView.layoutIfNeeded()
        }
    }
    private var top = 0.0
    private var leading = 0.0
    private var trailing = 0.0
    private var bottom = 0.0
    private var height: Double? {
        didSet {
            self.configLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commitInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commitInit()
    }
    
    init(
        _ gridView: GridView,
        renderer: BeagleRenderer
    ) {
        super.init(frame: .zero)
        self.gridView = gridView
        self.controller = renderer.controller
        self.template = gridView.template
        self.spanCount = gridView.spanCount
        self.direction = gridView.direction
        renderer.observe(gridView.dataSource, andUpdate: \.dataSource, in: self)
        renderer.observe(gridView.heightExpression, andUpdate: \.height, in: self)
        commitInit()
    }
    
    private func commitInit() {
        Bundle.main.loadNibNamed("GridViewUIComponent", owner: self, options: nil)
        self.addSubview(containView)
        containView.frame = bounds
        containView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.register(UINib(nibName: "GridViewCell", bundle: nil), forCellWithReuseIdentifier: "GridViewCell")
        
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        layout.scrollDirection = direction == ListView.Direction.vertical ? .vertical : .horizontal
        
        guard let isShowHorizontalIndicator = gridView?.isShowHorizontalIndicator, let isShowVerticalIndicator = gridView?.isShowVerticalIndicator else { return }
        collectionView.showsHorizontalScrollIndicator = isShowHorizontalIndicator
        collectionView.showsVerticalScrollIndicator = isShowVerticalIndicator
        configLayout()
    }
    
    private func configLayout() {
        guard let `gridView` = self.gridView, let margin = gridView.margin else { return }
        if let topConstant = margin.top?.value {
            top = topConstant
        }
        if let leadingConstant = margin.left?.value {
            leading = leadingConstant
        }
        if let trailingConstant = margin.right?.value {
            trailing = trailingConstant
        }
        if let bottomConstant = margin.bottom?.value {
            bottom = bottomConstant
        }
        if let horizontalConstant = margin.horizontal?.value {
            leading = horizontalConstant
            trailing = horizontalConstant
        }
        if let verticalConstant = margin.vertical?.value {
            top = verticalConstant
            bottom = verticalConstant
        }
        if let all = margin.all?.value {
            top = all
            leading = all
            trailing = all
            bottom = all
        }
        
        if let size = gridView.size, let height = size.height?.value {
            self.frame.size = CGSize(width: Double(UIScreen.main.bounds.size.width), height: height + top + bottom)
            heightConstraint.constant = CGFloat(height)
        }
        if let `height` = self.height {
            self.frame.size = CGSize(width: Double(UIScreen.main.bounds.size.width), height: height + top + bottom)
            heightConstraint.constant = CGFloat(height)
        }
        
        topConstraint.constant = CGFloat(top)
        bottomConstraint.constant = CGFloat(bottom)
        leadingConstraint.constant = CGFloat(leading)
        trailingConstraint.constant = CGFloat(trailing)
        
        self.layoutIfNeeded()
        self.collectionView.layoutIfNeeded()
    }
}

extension GridViewUIComponent: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridViewCell", for: indexPath) as! GridViewCell
        guard let `dataSource` = self.dataSource, let `template` = template, let `gridView` = gridView else { return cell }
        var container: ServerDrivenComponent!
        if indexPath.row == dataSource.count {
            container = gridView.otherTemplate
        } else {
            container = Container(
                children: [template], context: Context(
                    id: "item",
                    value: dataSource[indexPath.row]
                )
            )
        }
        cell.bindUIData(self.frame.size, gridView: gridView, top: top, leading: leading, trailing: trailing, bottom: bottom, template: container)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dataCount = dataSource?.count ?? 0
        return gridView?.otherTemplate != nil ? dataCount + 1 : dataCount
    }
}

extension GridViewUIComponent: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let itemSize = gridView?.itemSize else { return CGSize(width: 0, height: 0)}
        if direction == .vertical {
            let width = (self.frame.size.width - CGFloat(leading) - CGFloat(trailing)) / CGFloat(spanCount)
            return CGSize(width: Double(width), height: itemSize.height?.value ?? 0.0)
        } else {
            let height = (self.frame.size.height - CGFloat(top) - CGFloat(bottom)) / CGFloat(spanCount)
            return CGSize(width: itemSize.width?.value ?? 0.0, height: Double(height))
        }
    }
}

extension GridViewUIComponent: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView.frame.size.height > scrollView.contentSize.height - scrollView.contentOffset.y {
            controller?.execute(actions: gridView?.onScrollEnd, event: "onScrollEnd", origin: self)
        }
    }
}


