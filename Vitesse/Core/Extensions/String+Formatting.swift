//
//  String+Formatting.swift
//  Vitesse
//
//  Created by Jean Lejay on 5/8/26.
//

extension String {
    
    var formattedFrenchPhoneNumber: String {
        let digits = self.filter(\.isNumber)
        
        return stride(from: 0, to: digits.count, by: 2)
            .map {
                let start = digits.index(digits.startIndex, offsetBy: $0)
                let end = digits.index(
                    start,
                    offsetBy: 2,
                    limitedBy: digits.endIndex
                ) ?? digits.endIndex
                
                return String(digits[start..<end])
            }
            .joined(separator: " ")
    }
}
