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
  
  private var deliveryPersister: DeliveryPersister
  
  // MARK: - Lifecycle Events
  
  init(deliveryPersister: DeliveryPersister = CoreDataDeliveryPerister.shared) {
    
    // deliveryPersister can also be `UserDefaultsDeliveryPersister.shared`
    
    self.deliveryPersister = deliveryPersister
    self.deliveries = deliveryPersister.loadDeliveries()?.sorted(by: { $0.createdAt < $1.createdAt }) ?? [Delivery]()
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
    
    let favoriteIDs = deliveries.filter({ $0.isFavorite }).map({ $0.id })
    UserPreference.shared.favoriteIDs = Set(favoriteIDs)
    
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
      
      /*
       Remove all deliveries if user fetch deliveries for the first time or performed pull to refresh
       */
      
      if offset == 0 {
        self.deliveries.removeAll()
        self.deliveryPersister.removeAllDeliveries()
      }
      
      /*
       Mark new data as favorite according to the saved list of favorites
       */
      
      let favoriteIDs = UserPreference.shared.favoriteIDs
      
      let updatedDeliveries = deliveries
        .map { (delivery) -> Delivery in
          delivery.isFavorite = favoriteIDs?.contains(delivery.id) ?? false
          return delivery
        }
        .sorted(by: { $0.createdAt < $1.createdAt })
      
      /*
       Populate deliveries then save to local storage
       */
      
      self.deliveries.append(contentsOf: updatedDeliveries)
      self.deliveryPersister.saveDeliveries(deliveries: self.deliveries)
      
      /*
       Reload tableView
       */
      
      self.getDeliveriesSuccess.accept(true)
      
      /*
       Turn off activity indicator
       */
      
      self.isBusy.accept(false)
      self.isFetchingMorePages.accept(false)
    },
    onError: { error in
      
      print("failed")
      
      self.isBusy.accept(false)
      self.isFetchingMorePages.accept(false)
      self.errorMessage.accept("Something went wrong: \(error.localizedDescription)")
      
    }).disposed(by: disposeBag)
  }
}
