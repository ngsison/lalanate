//
//  OfflineStorage.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/12/20.
//

import Foundation
import CoreData

protocol DataStorageType {
  func saveDeliveries(deliveries: [Delivery])
  func loadDeliveries() -> [Delivery]?
}

struct LalaUserDefaultsStorage: DataStorageType {
  
  static let shared = LalaUserDefaultsStorage()
  private init() {}
  
  private let storage = UserDefaultsData.shared
  
  func saveDeliveries(deliveries: [Delivery]) {
    storage.deliveries = deliveries
  }
  
  func loadDeliveries() -> [Delivery]? {
    return storage.deliveries
  }
}

struct LalaCoreDataStorage: DataStorageType {
  
  static let shared = LalaCoreDataStorage()
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
