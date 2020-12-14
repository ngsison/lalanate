//
//  UIColorExtensionTests.swift
//  lalanateTests
//
//  Created by Nathaniel Brion Sison on 12/14/20.
//

import XCTest

@testable
import lalanate

class UIColorExtensionTests: XCTestCase {
  
  func testHexInitializerUppercased() {
    
    // arrange
    
    let color = UIColor(hex: "#FFFFFF")
    
    // act
    
    guard let components = color.cgColor.components else {
      XCTFail("invalid color")
      return
    }
    
    let red = 255 * components[0]
    let green = 255 * components[1]
    let blue = 255 * components[2]
    
    // assert
    
    XCTAssertEqual(red, 255)
    XCTAssertEqual(green, 255)
    XCTAssertEqual(blue, 255)
  }
  
  func testHexInitializerLowercased() {
    
    // arrange
    
    let color = UIColor(hex: "#ffffff")
    
    // act
    
    guard let components = color.cgColor.components else {
      XCTFail("invalid color")
      return
    }
    
    let red = 255 * components[0]
    let green = 255 * components[1]
    let blue = 255 * components[2]
    
    // assert
    
    XCTAssertEqual(red, 255)
    XCTAssertEqual(green, 255)
    XCTAssertEqual(blue, 255)
  }
}
