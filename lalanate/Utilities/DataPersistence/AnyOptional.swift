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
  var isNil: Bool { self == nil }
}
