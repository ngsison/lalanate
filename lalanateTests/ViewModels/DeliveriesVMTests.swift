//
//  DeliveriesVMTests.swift
//  lalanateTests
//
//  Created by Nathaniel Brion Sison on 12/14/20.
//

import XCTest

@testable
import lalanate

class DeliveriesVMTests: XCTestCase {
  
  private var vm: DeliveriesVM!
  
  override func setUpWithError() throws {
    
    vm = DeliveriesVM(deliveryPersister: InMemoryPersister())
    vm.httpClient.provider = LalaHttpClient.fakeMoyaProvider(statusCode: 200, responseDelay: 0)
  }
  
  func testToggleFavorite() {
    
    // arrange
    
    // act
    
    // assert
  }
}

fileprivate class InMemoryPersister: DeliveryPersister {
  
  private var deliveries = [Delivery]()
  
  func saveDeliveries(deliveries: [Delivery]) {
    self.deliveries = deliveries
  }
  
  func loadDeliveries() -> [Delivery]? {
    return deliveries
  }
  
  func removeAllDeliveries() {
    deliveries.removeAll()
  }
}
