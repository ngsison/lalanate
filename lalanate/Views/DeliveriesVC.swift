//
//  DeliveriesVC.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/10/20.
//

import UIKit
import SnapKit
import RxSwift

class DeliveriesVC: UIViewController {
  
  // MARK: - UI Props
  
  private lazy var tableView: UITableView = {
    let tv = UITableView()
    tv.separatorStyle = .none
    return tv
  }()
  
  // MARK: - Private Props
  
  private let vm = DeliveriesVM()
  private let disposeBag = DisposeBag()
  
  // MARK: - Lifecycle Events
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpViews()
    setUpTableView()
    setUpRxSubscriptions()
    
    vm.getDeliveries()
  }
  
  // MARK: - Private Methods
  
  private func setUpRxSubscriptions() {
    
    vm.isBusy
      .subscribe(onNext: { isBusy in
        print("isBusy: \(isBusy)")
      }).disposed(by: disposeBag)
    
    vm.getDeliveriesSuccess
      .filter({ $0 })
      .subscribe(onNext: { _ in
        self.tableView.reloadData()
      }).disposed(by: disposeBag)
    
    vm.errorMessage
      .filter({ !$0.isEmpty })
      .subscribe(onNext: { errorMessage in
        print(errorMessage)
      }).disposed(by: disposeBag)
  }
  
  private func setUpTableView() {
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(DeliveryCell.self, forCellReuseIdentifier: DeliveryCell.reuseIdentifier)
  }
  
  private func setUpViews() {
    
    title = "My Deliveries"
    view.backgroundColor = .white
    navigationItem.backButtonTitle = ""
    navigationController?.navigationBar.tintColor = .orange
    
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
}

// MARK: - UITableViewDataSource

extension DeliveriesVC: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return vm.deliveries.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryCell.reuseIdentifier,
                                             for: indexPath) as! DeliveryCell
    cell.configure(with: vm.deliveries[indexPath.row])
    
    return cell
  }
}

// MARK: - UITableViewDelegate

extension DeliveriesVC: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let deliveryDetailsVC = DeliveryDetailsVC()
    navigationController?.pushViewController(deliveryDetailsVC, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return DeliveryCell.preferredHeight
  }
}
