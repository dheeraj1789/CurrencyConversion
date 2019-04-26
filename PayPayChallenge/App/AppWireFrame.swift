//
//  AppWireFrame.swift
//  PayPayChallenge
//
//  Created by Dheeraj Kumar on 25/04/19.
//  Copyright © 2019 Dheeraj Kumar. All rights reserved.
//

import Foundation
import UIKit

class AppWireFrame : NSObject {
    func showRootViewController(_ viewController: UIViewController, inWindow: UIWindow) {
        let navigationController = navigationControllerFromWindow(inWindow)
        navigationController?.viewControllers = [viewController]
    }
    
    func navigationControllerFromWindow(_ window: UIWindow) -> UINavigationController? {
        let navigationController = window.rootViewController as? UINavigationController
        return navigationController
    }
}
