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
  public var deliveries = [Delivery]()
  
  // MARK: - Public Methods
  
  public func getDeliveries() {
    
    let target = DeliveriesAPI.getDeliveries(offset: 0, limit: 10)
    toggleIsBusy(to: true)
    
    httpClient.request(target: target) { (response) -> [Delivery] in
      
      let deliveries = try JSONDecoder().decode([Delivery].self, from: response.data)
      return deliveries
    }
    .subscribe(onNext: { deliveries in
      
      print("success")
      print(deliveries)
      
      self.deliveries = deliveries
      
      self.toggleIsBusy(to: false)
      self.getDeliveriesSuccess.accept(true)
    },
    onError: { error in
      
      print("failed")
      print(error)
      
      self.publishErrorMessage("Something went wrong")
      
    }).disposed(by: disposeBag)
  }
}
