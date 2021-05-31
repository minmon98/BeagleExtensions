//
//  GridView.swift
//  DemoBeagleApp
//
//  Created by VTN-MINHPV21 on 26/04/2021.
//

import Foundation
import Beagle

struct GridView: ServerDrivenComponent {
    var spanCount: Int = 2
    var context: Context?
    let onInit: [Action]?
    let dataSource: Expression<[DynamicObject]>?
    let key: String?
    var direction: ListView.Direction = .vertical
    let template: ServerDrivenComponent?
    let iteratorName: String?
    let onScrollEnd: [Action]?
    let scrollEndThreshold: Int?
    var widgetProperties: WidgetProperties = WidgetProperties()
    var size: Size?
    var heightExpression: Expression<Double>?
    var margin: EdgeValue?
    var itemSize: Size?
    var otherTemplate: ServerDrivenComponent?
    var isShowHorizontalIndicator: Bool?
    var isShowVerticalIndicator: Bool?
    
    func toView(renderer: BeagleRenderer) -> UIView {
        let view = GridViewUIComponent(self, renderer: renderer)
        return view
    }
}

extension GridView {
    enum CodingKeys: String, CodingKey {
        case spanCount
        case context
        case onInit
        case dataSource
        case key
        case direction
        case template
        case iteratorName
        case onScrollEnd
        case scrollEndThreshold
        case widgetProperties
        case size
        case margin
        case itemSize
        case otherTemplate
        case isShowHorizontalIndicator
        case isShowVerticalIndicator
        case heightExpression
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        spanCount = try container.decodeIfPresent(Int.self, forKey: .spanCount) ?? 0
        context = try container.decodeIfPresent(Context.self, forKey: .context)
        onInit = try container.decodeIfPresent(forKey: .onInit)
        onScrollEnd = try container.decodeIfPresent(forKey: .onScrollEnd)
        dataSource = try container.decodeIfPresent(Expression<[DynamicObject]>.self, forKey: .dataSource)
        key = try container.decodeIfPresent(String.self, forKey: .key)
        direction = try container.decodeIfPresent(ListView.Direction.self, forKey: .direction) ?? .vertical
        template = try container.decodeIfPresent(forKey: .template)
        iteratorName = try container.decodeIfPresent(String.self, forKey: .iteratorName)
        scrollEndThreshold = try container.decodeIfPresent(Int.self, forKey: .scrollEndThreshold)
        widgetProperties = try container.decodeIfPresent(WidgetProperties.self, forKey: .widgetProperties) ?? WidgetProperties()
        size = try container.decodeIfPresent(Size.self, forKey: .size)
        margin = try container.decodeIfPresent(EdgeValue.self, forKey: .margin)
        itemSize = try container.decodeIfPresent(Size.self, forKey: .itemSize)
        otherTemplate = try container.decodeIfPresent(forKey: .otherTemplate)
        isShowHorizontalIndicator = try container.decodeIfPresent(Bool.self, forKey: .isShowHorizontalIndicator)
        isShowVerticalIndicator = try container.decodeIfPresent(Bool.self, forKey: .isShowVerticalIndicator)
        heightExpression = try container.decodeIfPresent(Expression<Double>.self, forKey: .heightExpression)
    }
}
