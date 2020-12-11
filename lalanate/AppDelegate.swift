//
//  AppDelegate.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/10/20.
//

#if DEBUG
import netfox
#endif

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    setUpNetfox()
    
    window = UIWindow()
    window?.rootViewController = UINavigationController(rootViewController: DeliveriesVC())
    window?.makeKeyAndVisible()
    
    return true
  }
  
  private func setUpNetfox() {
    
    #if DEBUG
    NFX.sharedInstance().start()
    #endif
  }
}
