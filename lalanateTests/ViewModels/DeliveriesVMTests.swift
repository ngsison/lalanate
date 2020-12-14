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
  private let deliveryPersister = InMemoryPersister()
  
  override func setUpWithError() throws {
    
    vm = DeliveriesVM(deliveryPersister: deliveryPersister)
    vm.httpClient.provider = LalaHttpClient.fakeMoyaProvider(statusCode: 200, responseDelay: 0)
  }
  
  func testToggleFavorite() {
    
    // arrange
    
    let delivery = Delivery(context: getInMemoryManagedObjectContext())
    delivery.isFavorite = false
    
    vm.deliveries = [delivery]
    
    // act
    
    vm.toggleFavorite(for: delivery)
    
    // assert
    
    let persistedDelivery = deliveryPersister.loadDeliveries()!.first!
    
    XCTAssertTrue(persistedDelivery.isFavorite)
    XCTAssertTrue(vm.getDeliveriesSuccess.value)
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
