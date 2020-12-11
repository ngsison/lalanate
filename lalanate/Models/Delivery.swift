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
