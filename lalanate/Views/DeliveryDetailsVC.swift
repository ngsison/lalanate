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
  
  /*
   Scroll View
   */
  
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
  
  /*
   From and To
   */
  
  private lazy var fromToContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = .lalaLightGray
    return view
  }()
  
  private lazy var fromLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16, weight: .medium)
    label.text = "From"
    label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    return label
  }()
  
  private lazy var fromValueLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16)
    label.text = "Nathaniel Brion Sison"
    label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    return label
  }()
  
  private lazy var toLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16, weight: .medium)
    label.text = "To"
    label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    return label
  }()
  
  private lazy var toValueLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16)
    label.text = "Steve Jobs"
    label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    return label
  }()
  
  /*
   Goods to deliver
   */
  
  private lazy var goodsContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = .lalaLightGray
    return view
  }()
  
  /*
   Delivery Fee
   */
  
  private lazy var deliveryFeeContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = .lalaLightGray
    return view
  }()
  
  /*
   Favorite
   */
  
  private lazy var favoriteButton: UIButton = {
    let btn = UIButton()
    btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    btn.setTitle("Add to Favorite", for: .normal)
    btn.setTitleColor(.white, for: .normal)
    btn.backgroundColor = .orange
    btn.setCornerRadius(20)
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
    
    /*
     Favorite
     */
    
    view.addSubview(favoriteButton)
    favoriteButton.snp.makeConstraints { (make) in
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
      make.left.right.equalToSuperview().inset(20)
      make.height.equalTo(40)
    }
    
    /*
     From and To
     */
    
    fromToContainerView.addSubview(fromLabel)
    fromLabel.snp.makeConstraints { (make) in
      make.bottom.equalTo(fromToContainerView.snp.centerY).offset(-4)
      make.left.equalToSuperview().offset(10)
    }
    
    fromToContainerView.addSubview(fromValueLabel)
    fromValueLabel.snp.makeConstraints { (make) in
      make.centerY.equalTo(fromLabel)
      make.right.equalToSuperview().offset(-10)
      make.left.greaterThanOrEqualTo(fromLabel.snp.right).offset(10)
    }
    
    fromToContainerView.addSubview(toLabel)
    toLabel.snp.makeConstraints { (make) in
      make.top.equalTo(fromToContainerView.snp.centerY).offset(4)
      make.left.equalTo(fromLabel)
    }
    
    fromToContainerView.addSubview(toValueLabel)
    toValueLabel.snp.makeConstraints { (make) in
      make.centerY.equalTo(toLabel)
      make.right.equalTo(fromValueLabel)
      make.left.greaterThanOrEqualTo(toLabel.snp.right).offset(10)
    }
    
    contentView.addSubview(fromToContainerView)
    fromToContainerView.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(20)
      make.left.right.equalToSuperview().inset(20)
      make.height.equalTo(100)
    }
    
    /*
     Goods to deliver
     */
    
    contentView.addSubview(goodsContainerView)
    goodsContainerView.snp.makeConstraints { (make) in
      make.top.equalTo(fromToContainerView.snp.bottom).offset(20)
      make.left.right.equalToSuperview().inset(20)
      make.height.equalTo(200)
    }
    
    /*
     Delivery Fee
     */
    
    contentView.addSubview(deliveryFeeContainerView)
    deliveryFeeContainerView.snp.makeConstraints { (make) in
      make.top.equalTo(goodsContainerView.snp.bottom).offset(20)
      make.left.right.equalToSuperview().inset(20)
      make.height.equalTo(70)
    }
    
    /*
     Scroll View
     */
    
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
