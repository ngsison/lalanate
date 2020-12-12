//
//  OfflineStorage.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/12/20.
//

import Foundation

protocol OfflineStorage {
  func saveDeliveries(deliveries: [XDelivery])
  func loadDeliveries() -> [XDelivery]?
}

struct LalaOfflineStorage: OfflineStorage {
  
  static let shared = LalaOfflineStorage()
  private init() {}
  
  private let storage = UserDefaultsStorage.shared
  
  func saveDeliveries(deliveries: [XDelivery]) {
    storage.deliveries = deliveries
  }
  
  func loadDeliveries() -> [XDelivery]? {
    return storage.deliveries
  }
}
