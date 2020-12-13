//
//  Delivery.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/11/20.
//

import Foundation
import CoreData

@objc(Delivery)
class Delivery: NSManagedObject, Codable {
  
  @nonobjc
  public class func fetchRequest() -> NSFetchRequest<Delivery> {
    return NSFetchRequest<Delivery>(entityName: "Delivery")
  }
  
  // MARK: - Public Props
  
  @NSManaged public var id: String
  @NSManaged public var remarks: String
  @NSManaged public var pickupTime: String
  @NSManaged public var goodsPicture: String
  @NSManaged public var deliveryFee: String
  @NSManaged public var surcharge: String
  @NSManaged public var route: Route
  @NSManaged public var sender: Sender
  @NSManaged public var isFavorite: Bool
  
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
    
    guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext,
          let entity = NSEntityDescription.entity(forEntityName: "Delivery", in: context) else {
      throw DecoderError.missingManagedObjectContext
    }
    
    self.init(entity: entity, insertInto: context)
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.id = try container.decode(String.self, forKey: .id)
    self.remarks = try container.decode(String.self, forKey: .remarks)
    self.pickupTime = try container.decode(String.self, forKey: .pickupTime)
    self.goodsPicture = try container.decode(String.self, forKey: .goodsPicture)
    self.deliveryFee = try container.decode(String.self, forKey: .deliveryFee)
    self.surcharge = try container.decode(String.self, forKey: .surcharge)
    self.route = try container.decode(Route.self, forKey: .route)
    self.sender = try container.decode(Sender.self, forKey: .sender)
    self.isFavorite = try container.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false
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
  
  // MARK: - Public Methods
  
  public func getComputedDeliveryFee() -> Double? {
    
    guard let deliveryFee = getDoubleValue(for: self.deliveryFee),
          let surcharge = getDoubleValue(for: self.surcharge) else {
      
      return nil
    }
    
    return deliveryFee + surcharge
  }
  
  // MARK: - Private Methods
  
  private func getDoubleValue(for string: String) -> Double? {
    
    var allNumbers = ""
    
    for character in string {
      if character.isNumber || character == "." {
        allNumbers.append(character)
      }
    }
    
    return Double(allNumbers)
  }
}
