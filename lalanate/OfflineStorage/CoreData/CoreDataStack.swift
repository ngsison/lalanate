//
//  CoreDataStack.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/12/20.
//

import CoreData

/**
 Singleton that manages CoreData
 */

class CoreDataStack {
  
  static let shared = CoreDataStack()
  private init() {}
  
  // MARK: - Core Data Decoder
  
  /**
   Custom decoder for decoding a `Decodable` object that's also a subclass of `NSManagedObject`.
   */
  
  public var decoder: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.userInfo[CodingUserInfoKey.managedObjectContext] = CoreDataStack.shared.persistentContainer.viewContext
    return decoder
  }
  
  // MARK: - Core Data stack
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "lalanate")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  // MARK: - Core Data Saving support
  
  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}
