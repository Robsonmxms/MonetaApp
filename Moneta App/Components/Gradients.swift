//
//  Gradients.swift
//  Moneta App
//
//  Created by Robson Lopes on 17/05/22.
//

import SwiftUI

struct Gradients{
    
    
    
    static let stroke = AngularGradient(
        gradient: Gradient(colors: [
            Color("AccentColor"),
            Color("SplashBackground"),
            Color("Linear3"),
            Color("Linear4"),
        ]),
        center: .center,
        startAngle: .degrees(270),
        endAngle: .degrees(0))
    
    static let expensesGradient = AngularGradient(
        gradient: Gradient(colors: [
            Color(.gray),
            Color("DarkGray"),
            Color("Silver"),
            Color("LightGray"),

        ]),
        center: .center,
        startAngle: .degrees(90),
        endAngle: .degrees(0))
    
}
