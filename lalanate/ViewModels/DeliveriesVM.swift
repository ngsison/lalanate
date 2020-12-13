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
  
//  private let dataStore: DataStorageType = LalaUserDefaultsStorage.shared
  private let dataStore: DataStorageType = LalaCoreDataStorage.shared
  
  // MARK: - Lifecycle Events
  
  override init() {
    self.deliveries = dataStore.loadDeliveries() ?? [Delivery]()
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
    
    dataStore.saveDeliveries(deliveries: deliveries)
    getDeliveriesSuccess.accept(true)
  }
  
  public func getDeliveries() {
    
    guard !isBusy.value,
          deliveries.count < totalPages * itemPerPage else {
      return
    }
    
    print("offset: \(deliveries.count)")
    print("itemPerPage: \(itemPerPage)")
    
    let target = DeliveriesAPI.getDeliveries(offset: deliveries.count, limit: itemPerPage)
    
    toggleIsBusy(to: true)
    
    httpClient.request(target: target) { (response) -> [Delivery] in
      
      return try CoreDataStack.decoder.decode([Delivery].self, from: response.data)
    }
    .subscribe(onNext: { deliveries in
      
      print("success")
      
      self.deliveries.append(contentsOf: deliveries)
      self.dataStore.saveDeliveries(deliveries: self.deliveries)
      
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
