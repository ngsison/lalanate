//
//  Delivery.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/11/20.
//

import Foundation

// MARK: - Delivery

public struct Delivery: Codable {
  
  public var id: String
  public var remarks: String
  public var pickupTime: String
  public var goodsPicture: String
  public var deliveryFee: String
  public var surcharge: String
  public var route: Route
  public var sender: Sender
}
