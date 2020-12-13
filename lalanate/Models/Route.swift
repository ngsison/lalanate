//
//  Route.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/11/20.
//

import Foundation
import CoreData

class Route: NSObject, NSCoding, Codable {
  
  // MARK: - Public Props
  
  public var start: String
  public var end: String
  
  // MARK: - Conformance to NSCoding
  
  func encode(with coder: NSCoder) {
    coder.encode(start, forKey: "start")
    coder.encode(end, forKey: "end")
    
  }
  
  required init?(coder: NSCoder) {
    
    guard let start = coder.decodeObject(forKey: "start") as? String,
          let end = coder.decodeObject(forKey: "end") as? String else {
      return nil
    }
    
    self.start = start
    self.end = end
  }
}
