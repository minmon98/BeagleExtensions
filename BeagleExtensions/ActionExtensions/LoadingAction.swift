//
//  LoadingAction.swift
//  DemoBeagleApp
//
//  Created by Apple on 4/9/21.
//

import Foundation
import SVProgressHUD
import Beagle

class LoadingAction: Action {
    let isLoading: Bool
    
    init(isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    func execute(controller: BeagleController, origin: UIView) {
        if isLoading {
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.show()
        } else {
            SVProgressHUD.dismiss()
        }
    }
}
