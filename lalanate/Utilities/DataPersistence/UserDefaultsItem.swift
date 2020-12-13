//
//  UserDefaultsItem.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/12/20.
//

import Foundation

/**
 When a property is annotated with @UserDefaultsItem, its value will be saved to and retrieved from UserDefaults.
 */

@propertyWrapper
struct UserDefaultsItem<T> {
  
  public let key: String
  public let defaultValue: T
  public var storage: UserDefaults = .standard
  
  public var wrappedValue: T {
    
    get {
      let value = storage.value(forKey: key) as? T
      return value ?? defaultValue
    }
    
    set {
      if let optional = newValue as? AnyOptional, optional.isNil {
        storage.removeObject(forKey: key)
      } else {
        storage.setValue(newValue, forKey: key)
      }
    }
  }
}

extension UserDefaultsItem where T: ExpressibleByNilLiteral {
  
  /*
   Helper init method so we don't have to explicitly specify `nil` as default value
   */
  
  init(key: String, storage: UserDefaults = .standard) {
    self.init(key: key, defaultValue: nil, storage: storage)
  }
}
