//
//  MyFloatingButton.swift
//  DemoBeagleApp
//
//  Created by VTN-MINHPV21 on 09/04/2021.
//

import Foundation
import Beagle
import UIKit
import SDWebImage
import SwiftGifOrigin

class Button: UIButton {
    private var controller: BeagleController?
    private var floatingButton: FloatingButton?
    
    init(_ floatingButton: FloatingButton, renderer: BeagleRenderer) {
        super.init(frame: .infinite)
        self.addConstraints(anchor(topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 44, heightConstant: 44))
        frame.size = CGSize(width: 50, height: 50)
        self.floatingButton = floatingButton
        controller = renderer.controller
        
        backgroundColor = UIColor(hex: floatingButton.backgroundColor ?? "")
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 4.0
        layer.cornerRadius = 22
        addTarget(self, action: #selector(onChangeValue), for: .touchUpInside)
        
        if let image = floatingButton.image {
            setImage(UIImage(named: image), for: .normal)
            contentVerticalAlignment = .fill
            contentHorizontalAlignment = .fill
            imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        }
        if let gifName = floatingButton.gifImage {
            imageView?.layer.masksToBounds = true
            imageView?.layer.cornerRadius = 22
            let image = UIImage.gif(name: gifName)
            setImage(image, for: .normal)
        }
        if let display = floatingButton.display {
            self.isHidden = !display
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onChangeValue() {
        controller?.execute(actions: floatingButton?.onPress, event: "onPress", origin: self)
    }
}

struct FloatingButton: ServerDrivenComponent {
    let display: Bool?
    let image: String?
    let gifImage: String?
    let backgroundColor: String?
    let onPress: [Action]?
    
    func toView(renderer: BeagleRenderer) -> UIView {
        let button = Button(self, renderer: renderer)
        return button
    }
}

extension FloatingButton {
    enum CodingKeys: String, CodingKey {
        case display
        case image
        case gifImage
        case backgroundColor
        case onPress
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        backgroundColor = try container.decodeIfPresent(String.self, forKey: .backgroundColor)
        onPress = try container.decodeIfPresent(forKey: .onPress)
        gifImage = try container.decodeIfPresent(String.self, forKey: .gifImage)
        display = try container.decodeIfPresent(Bool.self, forKey: .display)
    }
}
