//
//  CodingUserInfoKeyExtension.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/12/20.
//

import Foundation

extension CodingUserInfoKey {
  
  /**
   Used for accessing `NSManagedObjectContext` from a `JSONDecoder`.
   */
  
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}
