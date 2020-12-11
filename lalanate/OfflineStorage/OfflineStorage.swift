//
//  OfflineStorage.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/12/20.
//

import Foundation

protocol OfflineStorage {
  func saveDeliveries(deliveries: [Delivery])
  func loadDeliveries() -> [Delivery]?
}

struct LalaOfflineStorage: OfflineStorage {
  
  private let storage = UserDefaultsStorage.shared
  
  func saveDeliveries(deliveries: [Delivery]) {
    storage.deliveries = deliveries
  }
  
  func loadDeliveries() -> [Delivery]? {
    return storage.deliveries
  }
}
