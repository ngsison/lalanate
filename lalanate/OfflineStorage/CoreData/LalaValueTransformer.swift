//
//  LalaValueTransformer.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/14/20.
//

import Foundation

/**
 Resolves warning: 'NSKeyedUnarchiveFromData' should not be used to for un-archiving and will be removed in a future release
 */

@available(iOS 12.0, *)
@objc(LalaValueTransformer)
final class LalaValueTransformer: NSSecureUnarchiveFromDataTransformer {
  
  static let name = NSValueTransformerName(rawValue: String(describing: LalaValueTransformer.self))
  
  override static var allowedTopLevelClasses: [AnyClass] {
    return [Route.self, Sender.self]
  }
  
  public static func register() {
    let transformer = LalaValueTransformer()
    ValueTransformer.setValueTransformer(transformer, forName: name)
  }
}
