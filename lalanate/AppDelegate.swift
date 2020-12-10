//
//  AppDelegate.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/10/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow()
    window?.rootViewController = DeliveriesVC()
    window?.makeKeyAndVisible()
    
    return true
  }
}
