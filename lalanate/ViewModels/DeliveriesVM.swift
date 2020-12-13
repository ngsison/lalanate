//
//  DeliveriesVM.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/11/20.
//

import Foundation
import RxCocoa

class DeliveriesVM: BaseVM {
  
  // MARK: - Public Props
  
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
          offset < totalPages * itemPerPage else {
      return
    }
    
    print("offset: \(offset)")
    
    if offset == 0 {
      deliveries.removeAll()
      getDeliveriesSuccess.accept(true)
    }
    
    let target = DeliveriesAPI.getDeliveries(offset: offset, limit: itemPerPage)
    
    toggleIsBusy(to: true)
    
    httpClient.request(target: target) { (response) -> [Delivery] in
      
      return try CoreDataStack.shared.decoder.decode([Delivery].self, from: response.data)
    }
    .subscribe(onNext: { deliveries in
      
      print("success")
      
      self.deliveries.append(contentsOf: deliveries)
      self.deliveryPersister.saveDeliveries(deliveries: self.deliveries)
      
      self.toggleIsBusy(to: false)
      self.getDeliveriesSuccess.accept(true)
    },
    onError: { error in
      
      print("failed")
      print(error.localizedDescription)
      
      self.publishErrorMessage("Something went wrong")
      
    }).disposed(by: disposeBag)
  }
}
