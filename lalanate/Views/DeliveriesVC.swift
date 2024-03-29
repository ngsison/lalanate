//
//  DeliveriesVC.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/10/20.
//

import RxSwift
import SnapKit
import UIKit

class DeliveriesVC: UIViewController {
  
  // MARK: - UI Props
  
  private lazy var tableView: UITableView = {
    let tv = UITableView()
    tv.separatorStyle = .none
    return tv
  }()
  
  private lazy var bottomActivityIndicator: UIActivityIndicatorView = {
    let ai = UIActivityIndicatorView()
    return ai
  }()
  
  // MARK: - Private Props
  
  private let vm = DeliveriesVM()
  private let disposeBag = DisposeBag()
  private let refreshControl = UIRefreshControl()
  
  // MARK: - Lifecycle Events
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpViews()
    setUpTableView()
    setUpRxSubscriptions()
    
    if vm.deliveries.isEmpty {
      vm.getDeliveries()
    }
  }
  
  // MARK: - Events
  
  @objc
  private func didRefresh() {
    vm.getDeliveries()
  }
  
  // MARK: - Private Methods
  
  private func setUpRxSubscriptions() {
    
    vm.isBusy
      .subscribe(onNext: { isBusy in
        isBusy
          ? self.refreshControl.beginRefreshing()
          : self.refreshControl.endRefreshing()
      }).disposed(by: disposeBag)
    
    vm.isFetchingMorePages
      .subscribe(onNext: { isFetchingMorePages in
        isFetchingMorePages
          ? self.bottomActivityIndicator.startAnimating()
          : self.bottomActivityIndicator.stopAnimating()
      }).disposed(by: disposeBag)
    
    vm.getDeliveriesSuccess
      .filter({ $0 })
      .subscribe(onNext: { _ in
        self.tableView.reloadData()
      }).disposed(by: disposeBag)
    
    vm.errorMessage
      .filter({ !$0.isEmpty })
      .subscribe(onNext: { errorMessage in
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        let alert = UIAlertController(title: "Oops!", message: errorMessage, preferredStyle: .alert)
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
        
      }).disposed(by: disposeBag)
  }
  
  private func setUpTableView() {
    
    refreshControl.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
    tableView.refreshControl = refreshControl
    
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
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return bottomActivityIndicator
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let deliveryDetailsVC = DeliveryDetailsVC(delivery: vm.deliveries[indexPath.row])
    deliveryDetailsVC.delegate = self
    
    navigationController?.pushViewController(deliveryDetailsVC, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return DeliveryCell.preferredHeight
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    let frameMaxY = scrollView.frame.maxY
    let contentMaxY = scrollView.contentSize.height - scrollView.contentOffset.y

    if contentMaxY < frameMaxY {
      vm.getDeliveries(offset: vm.deliveries.count)
    }
  }
}

// MARK: - DeliveryDetailsDelegate

extension DeliveriesVC: DeliveryDetailsDelegate {
  
  func deliveryDetails(_ deliveryDetailsVC: DeliveryDetailsVC, didToggleFavoriteFor delivery: Delivery) {
    
    vm.toggleFavorite(for: delivery)
    deliveryDetailsVC.navigationController?.popViewController(animated: true)
  }
}
