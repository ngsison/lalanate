//
//  DeliveryCell.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/10/20.
//

import UIKit
import SnapKit

class DeliveryCell: UITableViewCell {
  
  static let reuseIdentifier = "DeliveryCell"
  static let preferredHeight: CGFloat = 120
  
  // MARK: - UI Props
  
  private lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .lalaLightGray
    view.layer.cornerRadius = 10
    view.clipsToBounds = true
    return view
  }()
  
  private lazy var goodsImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.backgroundColor = .orange
    return iv
  }()
  
  private lazy var fromLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14)
    label.text = "From: Nathaniel Brion Sison"
    return label
  }()
  
  private lazy var toLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14)
    label.text = "To: Steve Jobs"
    label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    return label
  }()
  
  private lazy var favoriteImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.backgroundColor = .red
    return iv
  }()
  
  private lazy var deliveryFeeLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14)
    label.text = "$85"
    label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    return label
  }()
  
  // MARK: - Lifecycle Events
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setUpViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  // MARK: - Private Methods
  
  public func setUpViews() {
    
    selectionStyle = .none
    
    containerView.addSubview(goodsImageView)
    goodsImageView.snp.makeConstraints { (make) in
      make.top.left.bottom.equalToSuperview()
      make.width.equalTo(120)
    }
    
    containerView.addSubview(fromLabel)
    fromLabel.snp.makeConstraints { (make) in
      make.bottom.equalTo(containerView.snp.centerY).offset(-4)
      make.left.equalTo(goodsImageView.snp.right).offset(10)
    }
    
    containerView.addSubview(toLabel)
    toLabel.snp.makeConstraints { (make) in
      make.top.equalTo(containerView.snp.centerY).offset(4)
      make.left.equalTo(fromLabel)
    }
    
    containerView.addSubview(favoriteImageView)
    favoriteImageView.snp.makeConstraints { (make) in
      make.centerY.equalTo(fromLabel.snp.centerY)
      make.right.equalToSuperview().offset(-10)
      make.left.greaterThanOrEqualTo(fromLabel.snp.right).offset(10)
      make.width.height.equalTo(20)
    }
    
    containerView.addSubview(deliveryFeeLabel)
    deliveryFeeLabel.snp.makeConstraints { (make) in
      make.centerY.equalTo(toLabel)
      make.left.greaterThanOrEqualTo(toLabel.snp.right).offset(10)
      make.right.equalToSuperview().offset(-10)
    }
    
    addSubview(containerView)
    containerView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview().inset(10)
    }
  }
}
