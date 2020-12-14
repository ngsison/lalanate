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
    
    vm.deliveries = [Delivery]()
    deliveryPersister.removeAllDeliveries()
    
    vm.isBusy.accept(false)
    vm.isFetchingMorePages.accept(false)
    vm.getDeliveriesSuccess.accept(false)
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
  
  func testGetDeliveriesWithZeroOffset() {
    
    // act
    
    vm.getDeliveries()
    
    // assert
    
    XCTAssertEqual(vm.deliveries.count, 10)
    XCTAssertEqual(deliveryPersister.loadDeliveries()!.count, 10)
    
    XCTAssertFalse(vm.isBusy.value)
    XCTAssertFalse(vm.isFetchingMorePages.value)
    XCTAssertTrue(vm.getDeliveriesSuccess.value)
  }
  
  func testGetDeliveriesWithTenOffset() {
    
    // arrange
    
    vm.getDeliveries()
    
    // act
    
    vm.getDeliveries(offset: 10)
    
    // assert
    
    XCTAssertEqual(vm.deliveries.count, 20)
    XCTAssertEqual(deliveryPersister.loadDeliveries()!.count, 20)
    
    XCTAssertFalse(vm.isBusy.value)
    XCTAssertFalse(vm.isFetchingMorePages.value)
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
