//
//  MOSender.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/12/20.
//

import Foundation
import CoreData

class MOSender: NSManagedObject, Codable {
  
  // MARK: - Conformance to Decodable
  
  enum CodingKeys: CodingKey {
    case name
    case phone
    case email
  }
  
  required convenience init(from decoder: Decoder) throws {
    
    guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
      throw DecoderError.missingManagedObjectContext
    }
    
    self.init(context: context)
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.name = try container.decode(String.self, forKey: .name)
    self.phone = try container.decode(String.self, forKey: .phone)
    self.email = try container.decode(String.self, forKey: .email)
  }
  
  // MARK: - Conformance to Encodable
  
  func encode(to encoder: Encoder) throws {
    
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(name, forKey: .name)
    try container.encode(phone, forKey: .phone)
    try container.encode(email, forKey: .email)
  }
}
