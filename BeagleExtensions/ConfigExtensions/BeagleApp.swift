//
//  BeagleApp.swift
//  BeagleExtensions
//
//  Created by VTN-MINHPV21 on 31/05/2021.
//

import Foundation
import Beagle
import BeagleScaffold

public class BeagleApp {
    public static let shared = BeagleApp()
    
    func config(host: String) {
        let dependencies = BeagleDependencies()
        dependencies.urlBuilder = UrlBuilder(baseUrl: URL(string: host)!)
        
        let theme = AppTheme(styles: [
            "Title.Text.Orange": Styles.titleTextStyle,
            "Description.Text.Orange": Styles.descriptionTextStyle,
            "NormalBoldText": Styles.normalBoldTextStyle,
            "Title.Text.BasicDialog": Styles.basicDialogTextStyle,
            "Content.Text.BasicDialog": Styles.basicDialogContentStyle,
            "Accept.Button.BasicDialog": Styles.acceptButtonDialogStyle,
            "Cancel.Button.BasicDialog": Styles.cancelButtonDialogStyle,
            "OTP.ToPhoneNumber.Title": Styles.sendOTPToPhoneNumberStyle,
            "OTP.Header.Style": Styles.headerOTPStyle,
            "Not.ReceiveOTP.Title": Styles.notReceiveOTPStyle,
            "Resend.OTP.Style": Styles.resendOTPStyle,
            "Title.Text.StatisticStatus": Styles.statisticStatusTextStyle,
            "Title.Text.NumberStatus": Styles.statisticStatusNumberStyle,
            "Title.Text.IOCHome": Styles.titleIOCHomeStyle,
            "Button.Verify.OTP": Styles.verifyOTPStyle
        ])
        
        Beagle.dependencies = dependencies
        dependencies.theme = theme
        
        dependencies.decoder.register(action: LoadingAction.self)
        dependencies.decoder.register(action: NavigateAction.self)
        
        dependencies.decoder.register(component: OpenDatePicker.self)
        dependencies.decoder.register(component: ImagePicker.self)
        dependencies.decoder.register(component: FloatingButton.self)
        dependencies.decoder.register(component: GridView.self)
        dependencies.decoder.register(component: Label.self)
        dependencies.decoder.register(component: Card.self)
        dependencies.decoder.register(component: AccountBalance.self)
        dependencies.decoder.register(component: CustomOTPTextField.self)
        dependencies.decoder.register(component: PieChart.self)
        
        BeagleConfig.start(dependencies: dependencies)
    }
}
