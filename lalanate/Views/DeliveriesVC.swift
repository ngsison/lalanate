//
//  DeliveriesVC.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/10/20.
//

import UIKit
import SnapKit

class DeliveriesVC: UIViewController {
  
  private lazy var tableView: UITableView = {
    let tv = UITableView()
    return tv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpViews()
  }
  
  private func setUpViews() {
    
    view.backgroundColor = .white
    
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
}
