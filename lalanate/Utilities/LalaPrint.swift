//
//  LalaPrint.swift
//  lalanate
//
//  Created by Nathaniel Brion Sison on 12/11/20.
//

import Foundation

/**
 Prints information about the `file`, `line` and `function` of where the log originates.
 
 - Used to easily filter developer logs from system or external library logs.
 - Type 🔥 in logs filter to see all developer logs.
 */

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
