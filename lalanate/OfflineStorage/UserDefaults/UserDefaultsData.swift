//
//  UserDefaultsStorage.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/12/20.
//

import Foundation

class UserDefaultsData {
  
  static let shared = UserDefaultsData()
  private init() {}
  
  @UserDefaultsObject(key: "deliveries")
  public var deliveries: [Delivery]?
}
