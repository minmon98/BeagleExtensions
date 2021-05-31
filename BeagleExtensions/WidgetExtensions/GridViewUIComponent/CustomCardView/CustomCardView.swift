//
//  CustomCardView.swift
//  pbms
//
//  Created by VTN-MINHPV21 on 29/04/2021.
//  Copyright © 2021 Pham Binh. All rights reserved.
//

import UIKit
import MaterialComponents.MDCCard
import Beagle

class CustomCardView: UIView {
    @IBOutlet var containView: UIView!
    private var card: Card?
    private var controller: BeagleController?
    @IBOutlet weak var cardView: MDCCard!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
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
    
    init(_ card: Card, renderer: BeagleRenderer) {
        super.init(frame: .zero)
        self.card = card
        self.controller = renderer.controller
        renderer.observe(card.heightExpression, andUpdate: \.height, in: self)
        commitInit()
    }
    
    private func commitInit() {
        Bundle.main.loadNibNamed("CustomCardView", owner: self, options: nil)
        addSubview(containView)
        containView.frame = bounds
        containView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        configLayout()
    }
    
    private func configLayout() {
        guard let `card` = self.card, let margin = card.margin, let child = card.child else { return }
        var top = 0.0
        var leading = 0.0
        var trailing = 0.0
        var bottom = 0.0
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
        
        if let size = card.size, let height = size.height?.value {
            self.frame.size = CGSize(width: Double(UIScreen.main.bounds.size.width), height: height + top + bottom)
            heightConstraint.constant = CGFloat(height)
        }
        if let `height` = self.height {
            self.frame.size = CGSize(width: Double(UIScreen.main.bounds.size.width), height: height + top + bottom)
            heightConstraint.constant = CGFloat(height)
        }
        
        topConstraint.constant = CGFloat(top)
        bottomConstraint.constant = -CGFloat(bottom)
        leadingConstraint.constant = CGFloat(leading)
        trailingConstraint.constant = -CGFloat(trailing)
        
        let beagleView = BeagleView(child)
        cardView.addSubview(beagleView)
        beagleView.translatesAutoresizingMaskIntoConstraints = false
        beagleView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        beagleView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        beagleView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        beagleView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
    }
}
