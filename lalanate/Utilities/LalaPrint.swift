//
//  LalaPrint.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/11/20.
//

import Foundation

func print(filePath: String = #file, line: Int = #line, function: String = #function, _ message: String) {
  
  let fileName = getFileName(filePath)
  let dateTime = getDateFormatter().string(from: Date())
  
  Swift.print("🔥 ⏱ \(dateTime) 📁 \(fileName) #️⃣ \(line) 📞 \(function) 🗣 \(message)")
}

fileprivate func getFileName(_ filePath: String) -> String {
  
  if let fileName = filePath.split(separator: "/").last {
    return String(fileName)
  } else {
    return "Unknown"
  }
}

fileprivate func getDateFormatter() -> DateFormatter {
  
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
  dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600 * 8)
  
  return dateFormatter
}
