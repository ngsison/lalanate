//
//  UserDefaultsObject.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/12/20.
//

import Foundation

@propertyWrapper
struct UserDefaultsObject<T> where T: Codable {
  
  public let key: String
  public let defaultValue: T
  public var storage: UserDefaults = .standard
  
  public var wrappedValue: T {
    get {
      guard let data = storage.data(forKey: key),
            let object = try? CoreDataStack.decoder.decode(T.self, from: data) else {
        return defaultValue
      }
      return object
    }
    set {
      if let optional = newValue as? AnyOptional, optional.isNil {
        storage.removeObject(forKey: key)
      } else {
        if let data = try? JSONEncoder().encode(newValue) {
          storage.set(data, forKey: key)
        } else {
          storage.removeObject(forKey: key)
        }
      }
    }
  }
}

extension UserDefaultsObject where T: ExpressibleByNilLiteral {
  
  init(key: String, storage: UserDefaults = .standard) {
    self.init(key: key, defaultValue: nil, storage: storage)
  }
}
