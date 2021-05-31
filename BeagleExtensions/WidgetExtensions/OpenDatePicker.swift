//
//  OpenDatePicker.swift
//  DemoBeagleApp
//
//  Created by VTN-MINHPV21 on 27/04/2021.
//

import Foundation
import Beagle
import UIKit

class CustomDatePicker: UIDatePicker {
    private var datePicker: OpenDatePicker?
    private var controller: BeagleController?
    private var dateFormat: String?
    private var dateFormatter: DateFormatter!
    
    init(_ openDatePicker: OpenDatePicker, renderer: BeagleRenderer) {
        super.init(frame: .zero)
        self.datePicker = openDatePicker
        self.controller = renderer.controller
        self.dateFormat = openDatePicker.dateFormat
        self.datePickerMode = .date
        self.dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = dateFormat ?? "dd/MM/yy"
        self.addTarget(self, action: #selector(dateChange(_:)), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dateChange(_ sender: UIDatePicker) {
        let date = sender.date
        controller?.execute(actions: datePicker?.onChange, with: "onChange", and: .string(dateFormatter.string(from: date)), origin: self)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return super.sizeThatFits(.zero)
    }
}

struct OpenDatePicker: ServerDrivenComponent {
    var dateFormat: String?
    var onChange: [Action]?
    
    func toView(renderer: BeagleRenderer) -> UIView {
        let datePicker = CustomDatePicker(self, renderer: renderer)
        return datePicker
    }
}

extension OpenDatePicker {
    enum CodingKeys: String, CodingKey {
        case dateFormat
        case onChange
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        onChange = try container.decodeIfPresent(forKey: .onChange)
        dateFormat = try container.decodeIfPresent(String.self, forKey: .dateFormat)
    }
}
