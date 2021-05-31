//
//  AccountBalance.swift
//  pbms
//
//  Created by VTN-MINHPV21 on 07/05/2021.
//  Copyright © 2021 Pham Binh. All rights reserved.
//

import Foundation
import Beagle
import UIKit

class AccountBalanceButton: UIButton {
    private var controller: BeagleController?
    private var visible = false
    private var accountBalance: AccountBalance?
    
    init(_ accountBalance: AccountBalance, renderer: BeagleRenderer) {
        super.init(frame: .zero)
        self.controller = renderer.controller
        self.accountBalance = accountBalance
        var value = accountBalance.value ?? ""
        value = String(value.map({ _ -> Character in
            return "*"
        }))
        
        self.semanticContentAttribute = .forceRightToLeft
        self.setImage(UIImage(named: "invisible"), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        self.setTitle(value, for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        
        self.addTarget(self, action: #selector(changeValue), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func changeValue() {
        visible = !visible
        if visible {
            let value = accountBalance?.value ?? ""
            let currency = accountBalance?.currency ?? "VND"
            self.setImage(UIImage(named: "visible"), for: .normal)
            self.setTitle(value + " " + currency, for: .normal)
            self.sizeToFit()
        } else {
            let value = accountBalance?.value ?? ""
            self.setImage(UIImage(named: "invisible"), for: .normal)
            self.setTitle(String(value.map({ _ in return "*"})), for: .normal)
            self.sizeToFit()
        }
    }
}

struct AccountBalance: ServerDrivenComponent {
    var value: String?
    var currency: String?
    
    func toView(renderer: BeagleRenderer) -> UIView {
        let button = AccountBalanceButton(self, renderer: renderer)
        return button
    }
}

extension AccountBalance {
    enum CodingKeys: String, CodingKey {
        case value
        case currency
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try container.decodeIfPresent(String.self, forKey: .value)
        currency = try container.decodeIfPresent(String.self, forKey: .currency)
    }
}
