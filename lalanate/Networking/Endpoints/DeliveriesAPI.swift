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
    return "/v2/deliveries"
  }
  
  var method: Method {
    return .get
  }
  
  var sampleData: Data {
    return Data()
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
