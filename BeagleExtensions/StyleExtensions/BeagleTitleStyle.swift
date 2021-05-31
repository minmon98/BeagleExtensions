//
//  BeagleTitleStyle.swift
//  DemoBeagleApp
//
//  Created by VTN-MINHPV21 on 02/04/2021.
//

import Foundation
import Beagle

struct Styles {
    static func titleTextStyle() -> (UITextView?) -> Void {
        return BeagleStyle.text(
            font: UIFont.systemFont(ofSize: 20),
            color: .white
        )
    }
    
    static func descriptionTextStyle() -> (UITextView?) -> Void {
        return BeagleStyle.text(
            font: UIFont.systemFont(ofSize: 15),
            color: .white
        )
    }
    
    static func normalBoldTextStyle() -> (UITextView?) -> Void {
        return BeagleStyle.text(font: UIFont.systemFont(ofSize: 20, weight: .semibold), color: .black)
    }
    
    static func basicDialogTextStyle() -> (UITextView?) -> Void {
        return BeagleStyle.text(
            font: UIFont.systemFont(ofSize: 20, weight: .semibold), color: .black
        )
    }
    
    static func basicDialogContentStyle() -> (UITextView?) -> Void {
        return BeagleStyle.text(
            font: UIFont.systemFont(ofSize: 18),
            color: .gray
        )
    }
    
    static func acceptButtonDialogStyle() -> (UIButton?) -> Void {
        return BeagleStyle.button(withTitleColor: .white)
    }
    
    static func cancelButtonDialogStyle() -> (UIButton?) -> Void {
        return BeagleStyle.button(withTitleColor: .gray)
    }
    
    static func sendOTPToPhoneNumberStyle() -> (UITextView?) -> Void {
        return BeagleStyle.text(
            font: UIFont.systemFont(ofSize: 19, weight: .regular),
            color: UIColor(hex: "#9e9e9e")!
        )
    }
    
    static func headerOTPStyle() -> (UITextView?) -> Void {
        return BeagleStyle.text(
            font: UIFont.systemFont(ofSize: 20, weight: .semibold), color: .black)
    }
    
    static func notReceiveOTPStyle() -> (UITextView?) -> Void {
        return BeagleStyle.text(
            font: UIFont.systemFont(ofSize: 17, weight: .regular),
            color: UIColor(hex: "#8a8a8a")!
        )
    }
    
    static func resendOTPStyle() -> (UITextView?) -> Void {
        return BeagleStyle.text(
            font: UIFont.systemFont(ofSize: 17, weight: .regular), color: .black)
    }
    
    static func verifyOTPStyle() -> (UIButton?) -> Void {
        return BeagleStyle.button(withTitleColor: UIColor.white)
    }
    
    static func statisticStatusTextStyle() -> (UITextView?) -> Void {
        return  BeagleStyle.text(font: UIFont.systemFont(ofSize: 13, weight: .medium), color: UIColor.white)
    }
    
    static func statisticStatusNumberStyle() -> (UITextView?) -> Void {
        return BeagleStyle.text(font: UIFont.systemFont(ofSize: 30, weight: .semibold), color: UIColor.white)
    }
    
    static func titleIOCHomeStyle() -> (UITextView?) -> Void {
        return BeagleStyle.text(font: UIFont.systemFont(ofSize: 19, weight: .semibold), color: .white)
    }

}


