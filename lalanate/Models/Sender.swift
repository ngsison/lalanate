//
//  Sender.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/11/20.
//

import Foundation
import CoreData

@objc(Sender)
class Sender: NSManagedObject, Codable {
  
  @nonobjc
  public class func fetchRequest() -> NSFetchRequest<Sender> {
    return NSFetchRequest<Sender>(entityName: "Sender")
  }
  
  // MARK: - Public Props
  
  @NSManaged public var phone: String
  @NSManaged public var name: String
  @NSManaged public var email: String
  
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
