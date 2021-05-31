//
//  OTPTextField.swift
//  DemoBeagleApp
//
//  Created by Apple on 4/29/21.
//

import Foundation
import Beagle

struct CustomOTPTextField: ServerDrivenComponent {
    
    public var otpString: Expression<String>?
    public var onChange: [Action]?
    public var width: Int?
    public var height: Int?
    
    func toView(renderer: BeagleRenderer) -> UIView {
        let otpTextField = OTPTextField(self, renderer: renderer)
        otpTextField.frame.size.width = CGFloat(width ?? 0)
        otpTextField.frame.size.height = CGFloat(height ?? 0)
        let configuration = OTPFieldConfiguration(adapter: DefaultTextFieldAdapter(),
                                                  keyboardType: .namePhonePad,
                                                  keyboardAppearance: .light,
                                                  autocorrectionType: .no,
                                                  allowedCharactersSet: .alphanumerics)
        otpTextField.setConfiguration(configuration)
        otpTextField.onBeginEditing = {
            print("Handle Begin Editing")
        }
        otpTextField.onEndEditing = {
            print("Handle End Editing")
        }
        otpTextField.onOTPEnter = { code in
            print("Handle OTP entered action")
        }
        otpTextField.onTextChanged = { code in
            print(code!)
            print("Handle code changing")
        }
        
        return otpTextField
        
    }
}

extension CustomOTPTextField {
    
    enum CodingKeys: String, CodingKey {
        case otpString
        case width
        case height
        case onChange
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        otpString = try container.decodeIfPresent(Expression<String>.self, forKey: .otpString)
        width = try container.decodeIfPresent(Int.self, forKey: .width)
        height = try container.decodeIfPresent(Int.self, forKey: .height)
        onChange = try container.decodeIfPresent(forKey: .onChange)
    }
}
