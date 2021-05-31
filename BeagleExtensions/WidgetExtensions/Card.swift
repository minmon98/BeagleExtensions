//
//  Card.swift
//  pbms
//
//  Created by VTN-MINHPV21 on 29/04/2021.
//  Copyright © 2021 Pham Binh. All rights reserved.
//

import Foundation
import Beagle

struct Card: ServerDrivenComponent {
    var margin: EdgeValue?
    var size: Size?
    var child: ServerDrivenComponent?
    var heightExpression: Expression<Double>?
    
    func toView(renderer: BeagleRenderer) -> UIView {
        let customCardView = CustomCardView(self, renderer: renderer)
        return customCardView
    }
}

extension Card {
    enum CodingKeys: String, CodingKey {
        case margin
        case size
        case child
        case heightExpression
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        margin = try container.decodeIfPresent(EdgeValue.self, forKey: .margin)
        size = try container.decodeIfPresent(Size.self, forKey: .size)
        child = try container.decodeIfPresent(forKey: .child)
        heightExpression = try container.decodeIfPresent(Expression<Double>.self, forKey: .heightExpression)
    }
}
