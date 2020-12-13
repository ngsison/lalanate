//
//  JSONFileReader.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/12/20.
//

import Foundation

@objc
fileprivate class TestClass: NSObject {}

struct JSONFileReader {
  
  static func getDataFromJSONFile(_ filename: String) -> Data {
    
    var data: Data?
    
    let bundle = Bundle(for: TestClass.self)
    
    if let path = bundle.path(forResource: filename, ofType: "json") {
      let url = URL(fileURLWithPath: path)
      data = try? Data(contentsOf: url)
    }
    
    return data ?? Data()
  }
}
