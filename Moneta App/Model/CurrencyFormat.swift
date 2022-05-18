//
//  StringCurrencyFormated.swift
//  Moneta App
//
//  Created by Robson Lopes on 17/05/22.
//

import Foundation


class CurrencyFormat{
    private let numberFormatter: NumberFormatter
    
    private let value: Double
    
    let valueFormated: String
    
    init(_ value: Double) {
        self.numberFormatter = NumberFormatter()
        self.numberFormatter.usesGroupingSeparator = true
        self.numberFormatter.numberStyle = .currency
        self.numberFormatter.locale = Locale.current
        self.numberFormatter.maximumFractionDigits = 2
        
        self.value =  value
        
        self.valueFormated = numberFormatter.string(from: NSNumber(value: self.value))!
        
        
    }
    
}
