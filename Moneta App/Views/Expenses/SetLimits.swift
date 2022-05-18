//
//  SetLimits.swift
//  Moneta App
//
//  Created by Robson Lopes on 12/05/22.
//

import SwiftUI

struct SetLimits: View {
    
    @EnvironmentObject var expensesModel: ExpensesModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var value = 0
    
    private var numberFormatter: NumberFormatter
    
    init(numberFormatter: NumberFormatter = NumberFormatter()) {
        self.numberFormatter = numberFormatter
        self.numberFormatter.usesGroupingSeparator = true
        self.numberFormatter.numberStyle = .currency
        self.numberFormatter.locale = Locale.current
        self.numberFormatter.maximumFractionDigits = 2
        
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack{
                
                Button(action:{
                    dismiss()
                }){
                    Text("Cancel")
                        .foregroundColor(.red)
                        
                }
                
                Spacer()
                Text("Set your limit").font(.title3)
                Spacer()
                
                if value == 0{
                    Text("Done")
                        .foregroundColor(.secondary)
                }else{
                    Button(action:{
                        expensesModel.limit = Double(value)/100
                        
                        expensesModel.setLimitFormated()
                        expensesModel.setProportionValue()
                        
                        dismiss()
                    }){
                        Text("Done")
                            .foregroundColor(.accentColor)
                    }
                }
                
            }.frame(
                width: UIScreen.main.bounds.width*0.9,
                height: UIScreen.main.bounds.height*0.1
            )
            
            CurrencyTextField(numberFormatter: numberFormatter, value: $value)
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 16)
                    .stroke(Gradients.stroke, lineWidth: 2))
                .frame(
                    width: UIScreen.main.bounds.width*0.9,
                    height: UIScreen.main.bounds.height*0.15
                )
            
            Spacer()
        }
    }
    

}

struct SetLimits_Previews: PreviewProvider {
    static var previews: some View {
        SetLimits()
    }
}
