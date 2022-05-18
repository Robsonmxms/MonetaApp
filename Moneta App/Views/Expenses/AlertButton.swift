//
//  AlertButton.swift
//  Moneta App
//
//  Created by Robson Lopes on 18/05/22.
//

import SwiftUI

struct AlertButton: View {
    
    @EnvironmentObject var expensesModel: ExpensesModel
    
    @State private var showingAlert: Bool = false
    private var alertTitle: String = "Write short, descriptive, multiword alert titles"
    private var alertMessage: String = "Try to keep messages short enough to fit on one or two lines to prevent scrolling."
    private var alertButtonText: String = "Confirm"

    var body: some View {
        Button(action: {
            showingAlert = true
        }) {
            Text("Show Alert")
        }.alert(Text(alertTitle),
            isPresented: $showingAlert,
            actions: {
                Button(alertButtonText) {
                    expensesModel.resetToInitialValues()
                }
                Button("Cancel", role: .cancel) { }
            }, message: {
                Text(alertMessage)
            }
        )
    }
}

struct AlertButton_Previews: PreviewProvider {
    static var previews: some View {
        AlertButton()
    }
}
