//
//  CoreDataHelper.swift
//  lalanateTests
//
//  Created by Nathaniel Brion Sison on 12/14/20.
//

import CoreData

func getInMemoryManagedObjectContext() -> NSManagedObjectContext {
  
  let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
  
  let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
  
  do {
    try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
  } catch {
    print("Adding in-memory persistent store failed")
  }
  
  let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
  managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
  
  return managedObjectContext
}
