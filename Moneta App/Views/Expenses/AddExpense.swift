//
//  AddExpense.swift
//  Moneta App
//
//  Created by Robson Lopes on 12/05/22.
//

import SwiftUI

struct AddExpense: View {
    
    @EnvironmentObject var expensesModel: ExpensesModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var value = 0
    @State private var name = ""
    
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
                Text("Add your expense").font(.title3)
                Spacer()
                
                if name.isEmpty || value == 0{
                    Text("Done")
                        .foregroundColor(.secondary)
                }else{
                    Button(action:{
                        expensesModel.addExpense(
                            expense: Expense(
                                value: Double(value)/100,
                                name: name
                            )
                        )
                        expensesModel.setTotalValue()
                        expensesModel.setProportionValue()
                        expensesModel.setExpensesTotalValueFormated()
                        
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
            
            TextField("Name", text: $name)
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 16)
                    .stroke(Gradients.stroke, lineWidth: 2))
                .frame(
                    width: UIScreen.main.bounds.width*0.9
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

struct AddExpense_Previews: PreviewProvider {
    static var previews: some View {
        AddExpense()
    }
}
