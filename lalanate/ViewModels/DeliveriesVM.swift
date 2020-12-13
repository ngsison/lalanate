//
//  DeliveriesVM.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/11/20.
//

import CoreData
import Foundation
import RxCocoa

class DeliveriesVM: BaseVM {
  
  // MARK: - Public Props
  
  public var isFetchingMorePages = BehaviorRelay<Bool>(value: false)
  public var getDeliveriesSuccess = BehaviorRelay<Bool>(value: false)
  public var deliveries: [Delivery]
  
  // MARK: - Private Props
  
  private let totalPages = 5
  private let itemPerPage = 10
  
  // Value can be replaced with `UserDefaultsDeliveryPersister.shared`
  private let deliveryPersister: DeliveryPersister = CoreDataDeliveryPerister.shared
  
  // MARK: - Lifecycle Events
  
  override init() {
    self.deliveries = deliveryPersister.loadDeliveries() ?? [Delivery]()
    super.init()
  }
  
  // MARK: - Public Methods
  
  public func toggleFavorite(for delivery: Delivery) {
    
    deliveries = deliveries.map({ (oldDelivery) -> Delivery in
      
      if oldDelivery.id == delivery.id {
        oldDelivery.isFavorite.toggle()
      }
      
      return oldDelivery
    })
    
    deliveryPersister.saveDeliveries(deliveries: deliveries)
    getDeliveriesSuccess.accept(true)
  }
  
  public func getDeliveries(offset: Int = 0) {
    
    guard !isBusy.value,
          !isFetchingMorePages.value,
          offset < totalPages * itemPerPage else {
      return
    }
    
    print("offset: \(offset)")
    
    if offset == 0 {
      isBusy.accept(true)
    } else {
      isFetchingMorePages.accept(true)
    }
    
    let target = DeliveriesAPI.getDeliveries(offset: offset, limit: itemPerPage)
    
    httpClient.request(target: target) { (response) -> [Delivery] in
      
      return try CoreDataStack.shared.decoder.decode([Delivery].self, from: response.data)
    }
    .subscribe(onNext: { deliveries in
      
      print("success")
      
      if offset == 0 {
        self.deliveries.removeAll()
        self.deliveryPersister.removeAllDeliveries()
      }
      
      self.deliveries.append(contentsOf: deliveries)
      self.deliveryPersister.saveDeliveries(deliveries: self.deliveries)
      
      self.getDeliveriesSuccess.accept(true)
      
      self.isBusy.accept(false)
      self.isFetchingMorePages.accept(false)
    },
    onError: { error in
      
      print("failed")
      print(error.localizedDescription)
      
      self.isBusy.accept(false)
      self.isFetchingMorePages.accept(false)
      self.errorMessage.accept("Something went wrong")
      
    }).disposed(by: disposeBag)
  }
}
