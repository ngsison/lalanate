//
//  MODelivery.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/12/20.
//

import Foundation
import CoreData

class MODelivery: NSManagedObject, Codable {
  
  // MARK: - Conformance to Decodable
  
  enum CodingKeys: CodingKey {
    case id
    case remarks
    case pickupTime
    case goodsPicture
    case deliveryFee
    case surcharge
    case route
    case sender
    case isFavorite
  }
  
  required convenience init(from decoder: Decoder) throws {
    
    guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
      throw DecoderError.missingManagedObjectContext
    }
    
    self.init(context: context)
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.id = try container.decode(String.self, forKey: .id)
    self.remarks = try container.decode(String.self, forKey: .remarks)
    self.pickupTime = try container.decode(String.self, forKey: .pickupTime)
    self.goodsPicture = try container.decode(String.self, forKey: .goodsPicture)
    self.deliveryFee = try container.decode(String.self, forKey: .deliveryFee)
    self.surcharge = try container.decode(String.self, forKey: .surcharge)
    self.route = try container.decode(MORoute.self, forKey: .route)
    self.sender = try container.decode(MOSender.self, forKey: .sender)
    self.isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
  }
  
  // MARK: - Conformance to Encodable
  
  func encode(to encoder: Encoder) throws {
    
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    try container.encode(id, forKey: .id)
    try container.encode(remarks, forKey: .remarks)
    try container.encode(pickupTime, forKey: .pickupTime)
    try container.encode(goodsPicture, forKey: .goodsPicture)
    try container.encode(deliveryFee, forKey: .deliveryFee)
    try container.encode(surcharge, forKey: .surcharge)
    try container.encode(route, forKey: .route)
    try container.encode(sender, forKey: .sender)
    try container.encode(isFavorite, forKey: .isFavorite)
  }
}
