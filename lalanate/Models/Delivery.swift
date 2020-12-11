//
//  Delivery.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/11/20.
//

import Foundation

// MARK: - Delivery

public struct Delivery: Codable {
  
  // MARK: - Public Props
  
  public var id: String
  public var remarks: String
  public var pickupTime: String
  public var goodsPicture: String
  public var deliveryFee: String
  public var surcharge: String
  public var route: Route
  public var sender: Sender
  
  public var isFavorite = false
  
  // MARK: - Coding Keys
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case remarks = "remarks"
    case pickupTime = "pickupTime"
    case goodsPicture = "goodsPicture"
    case deliveryFee = "deliveryFee"
    case surcharge = "surcharge"
    case route = "route"
    case sender = "sender"
    
    case isFavorite = "isFavorite"
  }
  
  public init(from decoder: Decoder) throws {
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.id           = try container.decode(String.self, forKey: .id)
    self.remarks      = try container.decode(String.self, forKey: .remarks)
    self.pickupTime   = try container.decode(String.self, forKey: .pickupTime)
    self.goodsPicture = try container.decode(String.self, forKey: .goodsPicture)
    self.deliveryFee  = try container.decode(String.self, forKey: .deliveryFee)
    self.surcharge    = try container.decode(String.self, forKey: .surcharge)
    self.route        = try container.decode(Route.self, forKey: .route)
    self.sender       = try container.decode(Sender.self, forKey: .sender)
    
    self.isFavorite   = (try? container.decode(Bool.self, forKey: .isFavorite)) ?? false
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
