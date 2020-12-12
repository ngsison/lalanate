//
//  MOSender.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/12/20.
//

import Foundation
import CoreData

class MOSender: NSManagedObject, Decodable {
  
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
}
