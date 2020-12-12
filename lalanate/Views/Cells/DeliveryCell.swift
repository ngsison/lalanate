//
//  DeliveryCell.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/10/20.
//

import UIKit
import SnapKit
import Kingfisher

class DeliveryCell: UITableViewCell {
  
  static let reuseIdentifier = "DeliveryCell"
  static let preferredHeight: CGFloat = 120
  
  // MARK: - UI Props
  
  /*
   Container View
   */
  
  private lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .lalaLightGray
    view.setCornerRadius(10)
    return view
  }()
  
  /*
   Goods
   */
  
  private lazy var goodsImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()
  
  /*
   From and To
   */
  
  private lazy var fromLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16)
    return label
  }()
  
  private lazy var toLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16)
    label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    return label
  }()
  
  /*
   Favorite
   */
  
  private lazy var favoriteImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.image = #imageLiteral(resourceName: "favorite")
    return iv
  }()
  
  /*
   Delivery Fee
   */
  
  private lazy var deliveryFeeLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14, weight: .medium)
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
  
  // MARK: - Public Methods
  
  public func configure(with delivery: XDelivery) {
    
    fromLabel.text = "From: \(delivery.route.start)"
    toLabel.text = "To: \(delivery.route.end)"
    favoriteImageView.isHidden = !delivery.isFavorite
    
    if let computedDeliveryFee = delivery.getComputedDeliveryFee() {
      deliveryFeeLabel.text = String(format: "$ %.2f", computedDeliveryFee)
    } else {
      deliveryFeeLabel.text = "-"
    }
    
    if let imageURL = URL(string: delivery.goodsPicture) {
      goodsImageView.kf.setImage(with: imageURL, options: [.transition(.fade(0.5))])
    } else {
      goodsImageView.image = nil
    }
  }
  
  // MARK: - Private Methods
  
  public func setUpViews() {
    
    selectionStyle = .none
    
    /*
     Goods
     */
    
    containerView.addSubview(goodsImageView)
    goodsImageView.snp.makeConstraints { (make) in
      make.top.left.bottom.equalToSuperview()
      make.width.equalTo(110)
    }
    
    /*
     From and To
     */
    
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
    
    /*
     Favorite ImageView
     */
    
    containerView.addSubview(favoriteImageView)
    favoriteImageView.snp.makeConstraints { (make) in
      make.centerY.equalTo(fromLabel.snp.centerY)
      make.right.equalToSuperview().offset(-10)
      make.left.greaterThanOrEqualTo(fromLabel.snp.right).offset(10)
      make.width.height.equalTo(20)
    }
    
    /*
     Delivery Fee
     */
    
    containerView.addSubview(deliveryFeeLabel)
    deliveryFeeLabel.snp.makeConstraints { (make) in
      make.centerY.equalTo(toLabel)
      make.left.greaterThanOrEqualTo(toLabel.snp.right).offset(10)
      make.right.equalToSuperview().offset(-10)
    }
    
    /*
     Container View
     */
    
    addSubview(containerView)
    containerView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview().inset(10)
    }
  }
}
