//
//  NavigateAction.swift
//  BeagleExtensions
//
//  Created by VTN-MINHPV21 on 31/05/2021.
//

import Foundation
import Beagle

public class NavigateAction: Action {
    private var destination = ""
    
    init(destination: String) {
        self.destination = destination
    }
    
    public func execute(controller: BeagleController, origin: UIView) {
        let beagleController = Beagle.screen(.remote(.init(url: destination)))
        controller.present(beagleController, animated: true, completion: nil)
    }
}
