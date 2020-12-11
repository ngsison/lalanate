//
//  UIColorExtension.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/11/20.
//

import UIKit

extension UIColor {
  
  /// A color object with a white value of 0 and an alpha value of 0.1
  static let lalaLightGray = UIColor.init(white: 0, alpha: 0.1)
  
  /**
   Creates a color object using the given hex string.
   
   - Parameter hex: Hex string with # prefix.
   
   - Example 1: UIColor("#FFFFFF")
   - Example 2: UIColor("#ffffff")
   */
  
  convenience init(hex: String) {
    
    let r, g, b: CGFloat
    
    if hex.hasPrefix("#") {
      let start = hex.index(hex.startIndex, offsetBy: 1)
      let hexColor = String(hex[start...])
      
      if hexColor.count == 6 {
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
          r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
          g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
          b = CGFloat(hexNumber & 0x0000ff) / 255
          
          self.init(red: r, green: g, blue: b, alpha: 1)
          return
        }
      }
    }
    
    self.init()
  }
}
