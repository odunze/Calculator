//
//  AppDelegate.swift
//  Calculator
//
//  Created by Spencer Curtis on 1/9/19.
//  Copyright © 2019 Spencer Curtis. All rights reserved.
//

import UIKit
import RPN

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let w = UIWindow(frame: UIScreen.main.bounds)
        
        let root = UITabBarController()
        root.viewControllers = [
            CalculatorViewController(calculator: PrefixCalculator()),
            CalculatorViewController(calculator: InfixCalculator()),
            CalculatorViewController(calculator: PostfixCalculator())
        ]
        w.rootViewController = root
        w.makeKeyAndVisible()
        
        window = w
        
        return true
    }


}

