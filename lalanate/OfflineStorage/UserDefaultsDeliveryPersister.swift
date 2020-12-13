//
//  UserDefaultsDeliveryPersister.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/13/20.
//

import Foundation

/**
 Implementation of `DeliveryPersister` using `UserDefaults` as data store.
 */

struct UserDefaultsDeliveryPersister: DeliveryPersister {
  
  static let shared = UserDefaultsDeliveryPersister()
  private init() {}
  
  private let storage = UserDefaultsData.shared
  
  func saveDeliveries(deliveries: [Delivery]) {
    storage.deliveries = deliveries
  }
  
  func loadDeliveries() -> [Delivery]? {
    return storage.deliveries
  }
  
  func removeAllDeliveries() {
    storage.deliveries = nil
  }
}
