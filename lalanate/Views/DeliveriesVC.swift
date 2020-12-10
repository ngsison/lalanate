//
//  DeliveriesVC.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/10/20.
//

import UIKit
import SnapKit

class DeliveriesVC: UIViewController {
  
  // MARK: - UI Props
  
  private lazy var tableView: UITableView = {
    let tv = UITableView()
    tv.separatorStyle = .none
    return tv
  }()
  
  // MARK: - Lifecycle Events
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpViews()
    setUpTableView()
  }
  
  // MARK: - Private Methods
  
  private func setUpTableView() {
    
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.register(DeliveryCell.self, forCellReuseIdentifier: DeliveryCell.reuseIdentifier)
  }
  
  private func setUpViews() {
    
    view.backgroundColor = .white
    
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
}

// MARK: - UITableViewDataSource

extension DeliveriesVC: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryCell.reuseIdentifier,
                                             for: indexPath) as! DeliveryCell
    
    return cell
  }
}

// MARK: - UITableViewDelegate

extension DeliveriesVC: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return DeliveryCell.preferredHeight
  }
}
