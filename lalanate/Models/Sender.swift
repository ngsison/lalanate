//
//  Sender.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/11/20.
//

import CoreData
import Foundation

class Sender: NSObject, NSSecureCoding, Codable {
  
  // MARK: - Public Props
  
  public var name: String
  public var phone: String
  public var email: String
  
  // MARK: - Conformance to NSSecureCoding
  
  static var supportsSecureCoding: Bool = true
  
  func encode(with coder: NSCoder) {
    coder.encode(name, forKey: "name")
    coder.encode(phone, forKey: "phone")
    coder.encode(email, forKey: "email")
  }
  
  required init?(coder: NSCoder) {
    
    guard let name = coder.decodeObject(forKey: "name") as? String,
          let phone = coder.decodeObject(forKey: "phone") as? String,
          let email = coder.decodeObject(forKey: "email") as? String else {
      return nil
    }
    
    self.name = name
    self.phone = phone
    self.email = email
  }
}
