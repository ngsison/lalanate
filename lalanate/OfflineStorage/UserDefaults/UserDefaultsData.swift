//
//  UserDefaultsStorage.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/12/20.
//

import Foundation

/**
 Singleton that holds the data to be stored in and retrieved from UserDefaults
 */

class UserDefaultsData {
  
  static let shared = UserDefaultsData()
  private init() {}
  
  @UserDefaultsObject(key: "deliveries")
  public var deliveries: [Delivery]?
}
