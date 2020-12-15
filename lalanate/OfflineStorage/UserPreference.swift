//
//  UserPreference.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/16/20.
//

import Foundation

class UserPreference {
  
  static let shared = UserPreference()
  private init() {}
  
  @UserDefaultsObject(key: "favoriteIDs")
  public var favoriteIDs: Set<String>?
}
