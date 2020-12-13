//
//  AnyOptional.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/12/20.
//

import Foundation

protocol AnyOptional {
  var isNil: Bool { get }
}

extension Optional: AnyOptional {
  
  /// Helper property to validate if a value of generic type is optional.
  var isNil: Bool { self == nil }
}
