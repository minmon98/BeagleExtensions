//
//  NavigateAction.swift
//  BeagleExtensions
//
//  Created by VTN-MINHPV21 on 31/05/2021.
//

import Foundation
import Beagle

class NavigateAction: Action {
    var destination: String?
    var storyboardName: String?
    var controllerIdentification: String?
    
    enum CodingKeys: String, CodingKey {
        case destination
        case storyboardName
        case controllerIdentification
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        destination = try container.decodeIfPresent(String.self, forKey: .destination)
        storyboardName = try container.decodeIfPresent(String.self, forKey: .storyboardName)
        controllerIdentification = try container.decodeIfPresent(String.self, forKey: .controllerIdentification)
    }
    
    func execute(controller: BeagleController, origin: UIView) {
        if let `destination` = destination {
            let beagleController = Beagle.screen(.remote(.init(url: destination)))
            beagleController.modalPresentationStyle = .overFullScreen
            beagleController.modalTransitionStyle = .crossDissolve
            controller.present(beagleController, animated: true, completion: nil)
            return
        }
        
        if let `storyboardName` = storyboardName, let `controllerIdentification` = controllerIdentification {
            let viewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: controllerIdentification)
            viewController.modalPresentationStyle = .overFullScreen
            viewController.modalTransitionStyle = .crossDissolve
            controller.present(viewController, animated: true, completion: nil)
        }
    }
}
