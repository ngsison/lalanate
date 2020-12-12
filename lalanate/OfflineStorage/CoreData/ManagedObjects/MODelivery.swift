//
//  MODelivery.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/12/20.
//

import Foundation
import CoreData

class MODelivery: NSManagedObject, Decodable {
  
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
}
