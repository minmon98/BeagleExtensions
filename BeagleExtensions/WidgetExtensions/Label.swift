//
//  Label.swift
//  pbms
//
//  Created by VTN-MINHPV21 on 28/04/2021.
//  Copyright © 2021 Pham Binh. All rights reserved.
//

import Foundation
import Beagle
import UIKit

enum FontStyle: String {
    case SEMI_BOLD = "SEMI_BOLD"
    case BOLD = "BOLD"
    case ITALIC = "ITALIC"
    case UNDERLINE = "UNDERLINE"
    case NORMAL = "NORMAL"
}

class CustomLabel: UILabel {
    private var label: Label!
    
    override var text: String? {
        didSet {
            self.config()
        }
    }
    
    private var textColorString: String? {
        didSet {
            self.textColor = UIColor(hex: self.textColorString ?? "#000000")
        }
    }
    
    init(_ label: Label, renderer: BeagleRenderer) {
        super.init(frame: .zero)
        self.label = label
        config()
        renderer.observe(label.text, andUpdate: \.text, in: self)
        renderer.observe(label.textColor, andUpdate: \.textColorString, in: self)
    }
    
    private func config() {
        var customFont = UIFont()
        if let backgroundColor = label.backgroundColor {
            self.backgroundColor = UIColor(hex: backgroundColor)
        }
        if let cornerRadius = label.cornerRadius {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = CGFloat(cornerRadius)
        }
        if let numberOfLines = label.numberOfLines {
            self.numberOfLines = numberOfLines
        }
        if let textAlignment = label.textAlignment {
            switch textAlignment {
            case .left:
                self.textAlignment = .left
            case .right:
                self.textAlignment = .right
            case .center:
                self.textAlignment = .center
            }
        }
        if let fontStyle = label.fontStyle {
            switch fontStyle {
            case .BOLD:
                customFont = (label.fontName == nil ? UIFont.boldSystemFont(ofSize: CGFloat(label.fontSize ?? 17.0)) : UIFont(name: label.fontName!, size: CGFloat(label.fontSize ?? 17.0))) ?? UIFont()
                font = customFont
            case .SEMI_BOLD:
                customFont = (label.fontName == nil ? UIFont.systemFont(ofSize: CGFloat(label.fontSize ?? 17.0), weight: .semibold) : UIFont(name: label.fontName!, size: CGFloat(label.fontSize ?? 17.0))) ?? UIFont()
                font = customFont
            case .ITALIC:
                customFont = (label.fontName == nil ? UIFont.italicSystemFont(ofSize: CGFloat(label.fontSize ?? 17.0)) : UIFont(name: label.fontName!, size: CGFloat(label.fontSize ?? 17.0))) ?? UIFont()
                font = customFont
            case .UNDERLINE:
                let attributes: [NSAttributedString.Key : Any] = [
                    .underlineStyle: NSUnderlineStyle.single.rawValue,
                    .font: (label.fontName == nil ? UIFont.systemFont(ofSize: CGFloat(label.fontSize ?? 17.0)) : UIFont(name: label.fontName!, size: CGFloat(label.fontSize ?? 17.0))) ?? UIFont()
                ]
                let attributedString = NSAttributedString(string: text ?? "", attributes: attributes)
                attributedText = attributedString
            default:
                font = UIFont.systemFont(ofSize: CGFloat(label.fontSize ?? 17.0))
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct Label: ServerDrivenComponent {
    var text: Expression<String>?
    var textColor: Expression<String>?
    var cornerRadius: Double?
    var backgroundColor: String?
    var fontSize: Double?
    var fontName: String?
    var fontStyle: FontStyle?
    var numberOfLines: Int?
    var textAlignment: Text.Alignment? = .left
    
    func toView(renderer: BeagleRenderer) -> UIView {
        let label = CustomLabel(self, renderer: renderer)
        return label
    }
}

extension Label {
    enum CodingKeys: String, CodingKey {
        case text
        case textExpression
        case textColor
        case cornerRadius
        case backgroundColor
        case fontSize
        case fontName
        case fontStyle
        case numberOfLines
        case textAlignment
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decodeIfPresent(Expression<String>.self, forKey: .text)
        textColor = try container.decodeIfPresent(Expression<String>.self, forKey: .textColor)
        cornerRadius = try container.decodeIfPresent(Double.self, forKey: .cornerRadius)
        backgroundColor = try container.decodeIfPresent(String.self, forKey: .backgroundColor)
        fontSize = try container.decodeIfPresent(Double.self, forKey: .fontSize)
        fontName = try container.decodeIfPresent(String.self, forKey: .fontName)
        fontStyle = FontStyle(rawValue: try container.decodeIfPresent(String.self, forKey: .fontStyle) ?? FontStyle.NORMAL.rawValue)
        numberOfLines = try container.decodeIfPresent(Int.self, forKey: .numberOfLines)
        textAlignment = try container.decodeIfPresent(Text.Alignment.self, forKey: .textAlignment)
    }
}
