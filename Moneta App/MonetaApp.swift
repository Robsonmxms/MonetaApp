//
//  Moneta_AppApp.swift
//  Moneta App
//
//  Created by Robson Lopes on 10/05/22.
//

import SwiftUI

@main
struct MonetaApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                //SplashScreen()
                Expenses()
            }
            .navigationViewStyle(.stack)
            
        }
    }
}
