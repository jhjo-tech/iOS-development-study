//
//  AppDelegate.swift
//  alert0530
//
//  Created by Jo JANGHUI on 2018. 5. 30..
//  Copyright © 2018년 jhDAT. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = ViewController()
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        self.window = window
        
        
        return true
    }



}

