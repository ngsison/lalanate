//
//  UIViewExtensionTests.swift
//  lalanateTests
//
//  Created by Nathaniel Brion Sison on 12/14/20.
//

import XCTest

@testable
import lalanate

class UIViewExtensionTests: XCTestCase {

  func testSetCornerRadius() {
    
    // arrange
    
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    // act
    
    imageView.setCornerRadius(20)
    
    // assert
    
    XCTAssertTrue(imageView.clipsToBounds)
    XCTAssertEqual(imageView.layer.cornerRadius, 20)
  }
  
  func testSetSelectedCornerRadius() {
    
    // arrange
    
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    let corners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    let radius: CGFloat = 20
    
    // act
    
    imageView.setSelectedCornerRadius(corners: corners, radius: radius)
    
    // assert
    
    XCTAssertTrue(imageView.clipsToBounds)
    XCTAssertEqual(imageView.layer.cornerRadius, radius)
    XCTAssertEqual(imageView.layer.maskedCorners, corners)
  }
}
