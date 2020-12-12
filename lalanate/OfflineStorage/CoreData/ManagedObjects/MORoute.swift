//
//  MORoute.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/12/20.
//

import Foundation
import CoreData

class MORoute: NSManagedObject, Decodable {
  
  enum CodingKeys: CodingKey {
    case start
    case end
  }
  
  required convenience init(from decoder: Decoder) throws {
    
    guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
      throw DecoderError.missingManagedObjectContext
    }
    
    self.init(context: context)
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.start = try container.decode(String.self, forKey: .start)
    self.end = try container.decode(String.self, forKey: .end)
  }
}
