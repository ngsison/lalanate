//
//  DeliveriesAPI.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/11/20.
//

import Moya

enum DeliveriesAPI {
  case getDeliveries(offset: Int, limit: Int)
}

extension DeliveriesAPI: TargetType {
  
  var baseURL: URL {
    return URL(string: Constants.URLs.baseURL)!
  }
  
  var path: String {
    switch self {
    case .getDeliveries:
      return "/v2/deliveries"
    }
  }
  
  var method: Method {
    switch self {
    case .getDeliveries:
      return .get
    }
  }
  
  var sampleData: Data {
    switch self {
    case .getDeliveries:
      return JSONFileReader.getDataFromJSONFile("getDeliveriesResponse")
    }
  }
  
  var task: Task {
    switch self {
    case .getDeliveries(let offset, let limit):
      return .requestParameters(parameters: ["offset": offset,
                                             "limit": limit],
                                encoding: URLEncoding.queryString)
    }
  }
  
  var headers: [String : String]? {
    return nil
  }
}
