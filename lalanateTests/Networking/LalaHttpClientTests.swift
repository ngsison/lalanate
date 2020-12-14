//
//  LalaHttpClientTests.swift
//  lalanateTests
//
//  Created by Nathaniel Brion Sison on 12/14/20.
//

import Foundation
import Moya
import RxSwift
import XCTest

@testable
import lalanate

class LalaHttpClientTests: XCTestCase {
  
  private let disposeBag = DisposeBag()
  
  func testRequest() {
    
    // arrange
    
    var fetchedEmployees = [Employee]()
    
    let httpClient = LalaHttpClient()
    httpClient.provider = LalaHttpClient.fakeMoyaProvider(statusCode: 200,
                                                          responseDelay: 0,
                                                          data: employeesData)
    
    // act
    
    httpClient.request(target: EmployeeAPI.getEmployees) { (response) -> [Employee] in

      return try JSONDecoder().decode([Employee].self, from: response.data)
    }
    .subscribe(onNext: { employees in

      fetchedEmployees = employees
    },
    onError: { error in

      XCTFail(error.localizedDescription)

    }).disposed(by: disposeBag)
    
    // assert
    
    let employeeNames = fetchedEmployees.map { "\($0.firstName) \($0.lastName)" }
  
    XCTAssertEqual(employeeNames.count, 2)
    XCTAssertEqual(employeeNames[0], "Bill Gates")
    XCTAssertEqual(employeeNames[1], "Steve Jobs")
  }
}

// MARK: - Sample Model

struct Employee: Codable {
  var firstName: String
  var lastName: String
}

// MARK: - Sample Response Data

let employeesData = """

[
  {
    "firstName": "Bill",
    "lastName": "Gates",
  },
  {
    "firstName": "Steve",
    "lastName": "Jobs",
  }
]

""".data(using: .utf8)!

// MARK: - Sample Target

enum EmployeeAPI {
  case getEmployees
}

extension EmployeeAPI: TargetType {
  
  var baseURL: URL {
    return URL(string: "https://www.somevalidurl.com")!
  }
  
  var path: String {
    return ""
  }
  
  var method: Moya.Method {
    return .get
  }
  
  var sampleData: Data {
    return employeesData
  }
  
  var task: Task {
    return .requestPlain
  }
  
  var headers: [String : String]? {
    return nil
  }
}
