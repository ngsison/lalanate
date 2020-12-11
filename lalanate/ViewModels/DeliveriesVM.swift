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
  
  // MARK: - Private Props
  
  private var pageNumber = 0
  private let totalPages = 5
  private let itemPerPage = 10
  
  // MARK: - Public Methods
  
  public func getDeliveries() {
    
    let target = DeliveriesAPI.getDeliveries(offset: pageNumber * itemPerPage, limit: itemPerPage)
    
    toggleIsBusy(to: true)
    
    httpClient.request(target: target) { (response) -> [Delivery] in
      
      let deliveries = try JSONDecoder().decode([Delivery].self, from: response.data)
      return deliveries
    }
    .subscribe(onNext: { deliveries in
      
      print("success")
      
      self.pageNumber += 1
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
