//
//  DeliveryDetailsVC.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/11/20.
//

import SnapKit
import UIKit

protocol DeliveryDetailsDelegate {
  func deliveryDetails(_ deliveryDetailsVC: DeliveryDetailsVC, didToggleFavoriteFor delivery: Delivery)
}

class DeliveryDetailsVC: UIViewController {
  
  // MARK: - UI Props
  
  /*
   Scroll View
   */
  
  private lazy var scrollView: UIScrollView = {
    let sv = UIScrollView()
    sv.alwaysBounceVertical = true
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
    view.backgroundColor = .lalaBGColor
    view.setCornerRadius(10)
    return view
  }()
  
  private lazy var fromLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16, weight: .medium)
    label.text = "From:"
    label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    return label
  }()
  
  private lazy var fromValueLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16, weight: .medium)
    label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    return label
  }()
  
  private lazy var toLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16, weight: .medium)
    label.text = "To:"
    label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    return label
  }()
  
  private lazy var toValueLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16, weight: .medium)
    label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    return label
  }()
  
  /*
   Goods to deliver
   */
  
  private lazy var goodsContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = .lalaBGColor
    view.setCornerRadius(10)
    return view
  }()
  
  private lazy var goodsLabel: UILabel = {
    let label = UILabel()
    label.text = "Goods to deliver"
    label.font = .systemFont(ofSize: 16, weight: .medium)
    return label
  }()
  
  private lazy var goodsImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.setCornerRadius(10)
    iv.backgroundColor = .orange
    return iv
  }()
  
  /*
   Delivery Fee and Remarks
   */
  
  private lazy var deliveryFeeContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = .lalaBGColor
    view.setCornerRadius(10)
    return view
  }()
  
  private lazy var deliveryFeeLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16, weight: .medium)
    label.text = "Delivery Fee"
    label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    return label
  }()
  
  private lazy var deliveryFeeValueLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16, weight: .medium)
    label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    return label
  }()
  
  private lazy var remarksLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16, weight: .medium)
    label.text = "Remarks"
    return label
  }()
  
  private lazy var remarksValueLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 14, weight: .regular)
    label.numberOfLines = 0
    return label
  }()
  
  /*
   Favorite
   */
  
  private lazy var favoriteButton: UIButton = {
    let btn = UIButton(type: .system)
    btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    btn.setTitle("Add to Favorites", for: .normal)
    btn.setTitleColor(.white, for: .normal)
    btn.backgroundColor = .lalaButtonColor
    btn.setCornerRadius(20)
    btn.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
    return btn
  }()
  
  // MARK: - Public Props
  
  public var delegate: DeliveryDetailsDelegate?
  
  // MARK: - Private Props
  
  private var delivery: Delivery
  
  // MARK: - Lifecycle Events
  
  init(delivery: Delivery) {
    self.delivery = delivery
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpViews()
    populateDeliveryDetails()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    updateScrollViewContentSize()
  }
  
  // MARK: - Events
  
  @objc
  private func didTapFavorite() {
    delegate?.deliveryDetails(self, didToggleFavoriteFor: delivery)
  }
  
  // MARK: - Private Methods
  
  private func updateScrollViewContentSize() {
    
    let contentRect: CGRect = contentView.subviews
      .reduce(into: .zero) { rect, view in
        rect = rect.union(view.frame)
      }
    
    scrollView.contentSize = contentRect.size
  }
  
  private func populateDeliveryDetails() {
    
    fromValueLabel.text = delivery.route.start
    toValueLabel.text = delivery.route.end
    remarksValueLabel.text = delivery.remarks
    
    if let computedDeliveryFee = delivery.getComputedDeliveryFee() {
      deliveryFeeValueLabel.text = String(format: "$ %.2f", computedDeliveryFee)
    } else {
      deliveryFeeValueLabel.text = "-"
    }
    
    if let imageURL = URL(string: delivery.goodsPicture) {
      goodsImageView.kf.setImage(with: imageURL, options: [.transition(.fade(0.5))])
    } else {
      goodsImageView.image = nil
    }
    
    if delivery.isFavorite {
      favoriteButton.setTitle("Remove from Favorites", for: .normal)
    } else {
      favoriteButton.setTitle("Add to Favorites", for: .normal)
    }
  }
  
  private func setUpViews() {
    
    title = "Delivery Details"
    
    if #available(iOS 13.0, *) {
      view.backgroundColor = .systemBackground
    } else {
      view.backgroundColor = .white
    }
    
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
    
    contentView.addSubview(fromToContainerView)
    contentView.addSubview(fromLabel)
    contentView.addSubview(fromValueLabel)
    contentView.addSubview(toLabel)
    contentView.addSubview(toValueLabel)
    
    fromLabel.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(30)
      make.left.equalToSuperview().offset(20)
    }
    
    fromValueLabel.snp.makeConstraints { (make) in
      make.centerY.equalTo(fromLabel)
      make.right.equalToSuperview().offset(-20)
      make.left.greaterThanOrEqualTo(fromLabel.snp.right).offset(10)
    }
    
    toLabel.snp.makeConstraints { (make) in
      make.top.equalTo(fromLabel.snp.bottom).offset(4)
      make.left.equalTo(fromLabel)
    }
    
    toValueLabel.snp.makeConstraints { (make) in
      make.centerY.equalTo(toLabel)
      make.right.equalTo(fromValueLabel)
      make.left.greaterThanOrEqualTo(toLabel.snp.right).offset(10)
    }
    
    fromToContainerView.snp.makeConstraints { (make) in
      make.top.equalTo(fromLabel).offset(-10)
      make.left.right.equalToSuperview().inset(10)
      make.bottom.equalTo(toLabel).offset(10)
    }
    
    /*
     Goods to deliver
     */
    
    contentView.addSubview(goodsContainerView)
    contentView.addSubview(goodsLabel)
    contentView.addSubview(goodsImageView)
    
    goodsLabel.snp.makeConstraints { (make) in
      make.top.equalTo(fromToContainerView.snp.bottom).offset(30)
      make.left.right.equalToSuperview().inset(20)
    }
    
    goodsImageView.snp.makeConstraints { (make) in
      make.top.equalTo(goodsLabel.snp.bottom).offset(10)
      make.left.right.equalToSuperview().inset(20)
      make.height.equalTo(goodsImageView.snp.width)
    }
    
    goodsContainerView.snp.makeConstraints { (make) in
      make.top.equalTo(goodsLabel).offset(-10)
      make.left.right.equalToSuperview().inset(10)
      make.bottom.equalTo(goodsImageView).offset(10)
    }
    
    /*
     Delivery Fee and Remarks
     */
    
    contentView.addSubview(deliveryFeeContainerView)
    contentView.addSubview(deliveryFeeLabel)
    contentView.addSubview(deliveryFeeValueLabel)
    contentView.addSubview(remarksLabel)
    contentView.addSubview(remarksValueLabel)
    
    deliveryFeeLabel.snp.makeConstraints { (make) in
      make.top.equalTo(goodsContainerView.snp.bottom).offset(30)
      make.left.equalToSuperview().offset(20)
    }
    
    deliveryFeeValueLabel.snp.makeConstraints { (make) in
      make.centerY.equalTo(deliveryFeeLabel)
      make.right.equalToSuperview().offset(-20)
      make.left.greaterThanOrEqualTo(deliveryFeeLabel.snp.right).offset(20)
    }
    
    remarksLabel.snp.makeConstraints { (make) in
      make.top.equalTo(deliveryFeeLabel.snp.bottom).offset(10)
      make.left.equalTo(deliveryFeeLabel)
    }
    
    remarksValueLabel.snp.makeConstraints { (make) in
      make.top.equalTo(remarksLabel.snp.bottom).offset(10)
      make.left.right.equalToSuperview().inset(20)
    }
    
    deliveryFeeContainerView.snp.makeConstraints { (make) in
      make.top.equalTo(deliveryFeeLabel).offset(-10)
      make.left.right.equalToSuperview().inset(10)
      make.bottom.equalTo(remarksValueLabel).offset(10)
    }
    
    /*
     Scroll View
     */
    
    scrollView.addSubview(contentView)
    contentView.snp.makeConstraints { (make) in
      make.edges.width.height.equalToSuperview()
    }
    
    view.addSubview(scrollView)
    scrollView.snp.makeConstraints { (make) in
      make.top.left.right.equalToSuperview()
      make.bottom.equalTo(favoriteButton.snp.top).offset(-20)
    }
  }
}
