//
//  DeliveryDetailsVC.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/11/20.
//

import UIKit

class DeliveryDetailsVC: UIViewController {
  
  // MARK: - Lifecycle Events
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpViews()
  }
  
  // MARK: - Private Methods
  
  private func setUpViews() {
    
    title = "Delivery Details"
    view.backgroundColor = .white
  }
}
