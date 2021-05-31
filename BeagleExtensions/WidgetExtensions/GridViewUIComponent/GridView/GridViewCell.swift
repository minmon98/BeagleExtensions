//
//  GridViewCell.swift
//  DemoBeagleApp
//
//  Created by VTN-MINHPV21 on 26/04/2021.
//

import UIKit
import Beagle

class GridViewCell: UICollectionViewCell {
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var beagleContainerView: UIView!
    private var beagleView: BeagleView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        beagleView?.removeFromSuperview()
        beagleView = nil
    }
    
    func bindUIData(_ gridViewFrame: CGSize, gridView: GridView, top: Double, leading: Double, trailing: Double, bottom: Double, template: ServerDrivenComponent) {
        if let itemSize = gridView.itemSize {
            if gridView.direction == .vertical {
                let width = (gridViewFrame.width - CGFloat(leading) - CGFloat(trailing)) / CGFloat(gridView.spanCount)
                let height = itemSize.height?.value ?? 0.0
                self.frame.size = CGSize(width: width, height: CGFloat(height))
                heightConstraint.constant = CGFloat(height)
                widthConstraint.constant = width
            } else {
                let height = (gridViewFrame.height - CGFloat(top) - CGFloat(bottom)) / CGFloat(gridView.spanCount)
                let width = itemSize.width?.value ?? 0.0
                self.frame.size = CGSize(width: CGFloat(width), height: height)
                heightConstraint.constant = height
                widthConstraint.constant = CGFloat(width)
            }
        }
        
        beagleView = BeagleView(template)
        beagleContainerView.addSubview(beagleView!)
        beagleView?.translatesAutoresizingMaskIntoConstraints = false
        beagleView?.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        beagleView?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        beagleView?.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        beagleView?.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
