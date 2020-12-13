//
//  DeliveryPersister.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/13/20.
//

/**
 A type that can save and load "deliveries" to any persistent storage.
 */

protocol DeliveryPersister {
  func saveDeliveries(deliveries: [Delivery])
  func loadDeliveries() -> [Delivery]?
  func removeAllDeliveries()
}
