//
//  Route.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/11/20.
//

import CoreData
import Foundation

class Route: NSObject, NSSecureCoding, Codable {
  
  // MARK: - Public Props
  
  public var start: String
  public var end: String
  
  // MARK: - Conformance to NSSecureCoding
  
  static var supportsSecureCoding: Bool = true
  
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
