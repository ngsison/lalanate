//
//  DeliveryTests.swift
//  lalanateTests
//
//  Created by Nathaniel Brion Sison on 12/14/20.
//

import XCTest

@testable
import lalanate

class DeliveryTests: XCTestCase {
  
  var delivery: Delivery!

  override func setUpWithError() throws {
    
    delivery = Delivery(context: getInMemoryManagedObjectContext())
    
    delivery.pickupTime = "2014-10-06T10:45:38-08:00"
    delivery.deliveryFee = "$92.14"
    delivery.surcharge = "$136.46"
  }
  
  func testGetComputedDeliveryFee() {
    
    // arrange
    
    guard let computedDeliveryFee = delivery.getComputedDeliveryFee() else {
      XCTFail("computedDeliveryFee is nil")
      return
    }
    
    // act
    
    let formattedDeliveryFee = String(format: "%.2f", computedDeliveryFee)
    
    // assert
    
    XCTAssertEqual(formattedDeliveryFee, "228.60")
  }
  
  func testGetPickupTime() {
    
    // arrange
    
    guard let pickupTime = delivery.getPickupTime() else {
      XCTFail("pickupTime is nil")
      return
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    dateFormatter.timeZone = TimeZone(secondsFromGMT: -(3600 * 8))
    
    // act
    
    let formattedDate = dateFormatter.string(from: pickupTime)
    
    // assert
    
    XCTAssertEqual(formattedDate, "2014-10-06T10:45:38-08:00")
  }
}
