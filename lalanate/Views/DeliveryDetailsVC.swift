//
//  DeliveryDetailsVC.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/11/20.
//

import UIKit
import SnapKit

class DeliveryDetailsVC: UIViewController {
  
  // MARK: - UI Props
  
  private lazy var scrollView: UIScrollView = {
    let sv = UIScrollView()
    sv.alwaysBounceVertical = true
    sv.backgroundColor = .white
    return sv
  }()
  
  private lazy var contentView: UIView = {
    let view = UIView()
    return view
  }()
  
  private lazy var fromToContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = .init(white: 0, alpha: 0.1)
    return view
  }()
  
  private lazy var goodsContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = .init(white: 0, alpha: 0.1)
    return view
  }()
  
  private lazy var deliveryFeeContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = .init(white: 0, alpha: 0.1)
    return view
  }()
  
  private lazy var favoriteButton: UIButton = {
    let btn = UIButton()
    btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    btn.setTitle("Add to Favorite", for: .normal)
    btn.setTitleColor(.white, for: .normal)
    btn.backgroundColor = .orange
    btn.layer.cornerRadius = 20
    btn.clipsToBounds = true
    return btn
  }()
  
  // MARK: - Lifecycle Events
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpViews()
  }
  
  // MARK: - Private Methods
  
  private func setUpViews() {
    
    title = "Delivery Details"
    view.backgroundColor = .white
    
    view.addSubview(favoriteButton)
    favoriteButton.snp.makeConstraints { (make) in
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
      make.left.right.equalToSuperview().inset(20)
      make.height.equalTo(40)
    }
    
    contentView.addSubview(fromToContainerView)
    fromToContainerView.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(20)
      make.left.right.equalToSuperview().inset(20)
      make.height.equalTo(100)
    }
    
    contentView.addSubview(goodsContainerView)
    goodsContainerView.snp.makeConstraints { (make) in
      make.top.equalTo(fromToContainerView.snp.bottom).offset(20)
      make.left.right.equalToSuperview().inset(20)
      make.height.equalTo(200)
    }
    
    contentView.addSubview(deliveryFeeContainerView)
    deliveryFeeContainerView.snp.makeConstraints { (make) in
      make.top.equalTo(goodsContainerView.snp.bottom).offset(20)
      make.left.right.equalToSuperview().inset(20)
      make.height.equalTo(70)
    }
    
    scrollView.addSubview(contentView)
    contentView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
      make.width.equalToSuperview()
      make.height.equalTo(450)
    }
    
    view.addSubview(scrollView)
    scrollView.snp.makeConstraints { (make) in
      make.top.left.right.equalToSuperview()
      make.bottom.equalTo(favoriteButton.snp.top).offset(-10)
    }
  }
}
