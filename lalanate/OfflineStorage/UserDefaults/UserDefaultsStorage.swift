//
//  UserDefaultsStorage.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/12/20.
//

import Foundation

class UserDefaultsStorage {
  
  static let shared = UserDefaultsStorage()
  private init() {}
  
  @UserDefaultsObject(key: "deliveries")
  public var deliveries: [XDelivery]?
}
