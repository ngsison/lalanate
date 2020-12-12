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
  public var deliveries = LalaOfflineStorage.shared.loadDeliveries() ?? [XDelivery]()
  
  // MARK: - Private Props
  
  private let totalPages = 5
  private let itemPerPage = 10
  
  // MARK: - Public Methods
  
  public func toggleFavorite(for delivery: XDelivery) {
    
    deliveries = deliveries.map({ (oldDelivery) -> XDelivery in
      
      var mutableDelivery = oldDelivery
      
      if mutableDelivery.id == delivery.id {
        mutableDelivery.isFavorite.toggle()
      }
      
      return mutableDelivery
    })
    
    LalaOfflineStorage.shared.saveDeliveries(deliveries: deliveries)
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
    
    httpClient.request(target: target) { (response) -> [XDelivery] in
      
      let deliveries = try JSONDecoder().decode([XDelivery].self, from: response.data)
      return deliveries
    }
    .subscribe(onNext: { deliveries in
      
      print("success")
      
      self.deliveries.append(contentsOf: deliveries)
      self.toggleIsBusy(to: false)
      
      LalaOfflineStorage.shared.saveDeliveries(deliveries: self.deliveries)
      self.getDeliveriesSuccess.accept(true)
    },
    onError: { error in
      
      print("failed")
      print(error)
      
      self.publishErrorMessage("Something went wrong")
      
    }).disposed(by: disposeBag)
  }
}
