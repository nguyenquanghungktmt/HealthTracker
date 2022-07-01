//
//  String+Extensions.swift
//  HealthyTracker
//
//  Created by pc_1359 on 24/06/2022.
//
extension String {
    func components(withMaxLength length: Int) -> [String] {
        return stride(from: 0, to: self.count, by: length).map {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            return String(self[start..<end])
        }
    }
    
    static func dateConvert(date:String = "dd/mm/yyyy") -> String {
        let stringArray = date.split(separator: "/")
        return "\(stringArray[0]) tháng \(stringArray[1]), \(stringArray[2])"
    }
}
