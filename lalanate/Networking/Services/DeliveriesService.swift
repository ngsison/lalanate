//
//  DeliveriesService.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/11/20.
//

import Foundation

protocol DeliveriesServiceType {
  func getDeliveries(offset: Int, limit: Int)
}
