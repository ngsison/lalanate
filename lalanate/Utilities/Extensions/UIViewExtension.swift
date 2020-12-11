//
//  UIViewExtension.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/11/20.
//

import UIKit

extension UIView {
  
  /**
   Apply corner radius to a view.
   */
  
  func setCornerRadius(_ radius: CGFloat) {
    self.clipsToBounds = true
    self.layer.cornerRadius = radius
  }
  
  /**
   Apply corner radius only to the specified `corners` of a view.
   */
  
  func setSelectedCornerRadius(corners: CACornerMask, radius: CGFloat) {
    self.clipsToBounds = true
    self.layer.cornerRadius = radius
    self.layer.maskedCorners = corners
  }
}
