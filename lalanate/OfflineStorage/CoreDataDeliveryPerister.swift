//
//  CoreDataDeliveryPerister.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/13/20.
//

import Foundation
import CoreData

/**
 Implementation of `DeliveryPersister` using `CoreData` as data store.
 */

struct CoreDataDeliveryPerister: DeliveryPersister {
  
  static let shared = CoreDataDeliveryPerister()
  private init() {}
  
  private let persistentContainer = CoreDataStack.shared.persistentContainer
  
  func saveDeliveries(deliveries: [Delivery]) {
    
    CoreDataStack.shared.saveContext()
  }
  
  func loadDeliveries() -> [Delivery]? {
    
    do {
      return try persistentContainer.viewContext.fetch(Delivery.fetchRequest())
    } catch {
      print("fetchRequest failed with error: \(error)")
      return nil
    }
  }
}
