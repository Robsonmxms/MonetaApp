//
//  ExpensesModel.swift
//  Moneta App
//
//  Created by Robson Lopes on 13/05/22.
//

import Foundation

class ExpensesModel: ObservableObject{
    
    @Published var limit: Double = 0
    
    @Published var limitFormated: String = ""
    
    @Published var expenses: [Expense] = []
    
    @Published var totalValue: Double = 0
    
    @Published var totalValueFormated: String = ""
    
    @Published var proportionValue: Double = 0
    
    init(){
        setLimitFormated()
        setExpensesTotalValueFormated()
    }
    
    func resetToInitialValues() {
        self.limit = 0
        self.limitFormated = ""
        self.expenses = []
        self.totalValue = 0
        self.totalValueFormated = ""
        self.proportionValue = 0
        
        setLimitFormated()
        setExpensesTotalValueFormated()
    }
    
    func setProportionValue(){
        if self.limit == 0{
            self.proportionValue = 0
        }else{
            self.proportionValue = self.totalValue/self.limit
        }
    }
    
    func setExpensesTotalValueFormated(){
        self.totalValueFormated = CurrencyFormat(self.totalValue).valueFormated
    }
    
    func setLimitFormated(){
        self.limitFormated = CurrencyFormat(self.limit).valueFormated
    }
    
    func addExpense(expense: Expense){
        self.expenses.append(expense)
    }
    
    func setTotalValue(){
        self.totalValue = 0
        
        for expense in self.expenses{
            self.totalValue += expense.value
        }
    }
    func deleteExpense(indexSet: IndexSet) {
        self.expenses.remove(atOffsets: indexSet)
        
        self.setTotalValue()
        self.setExpensesTotalValueFormated()
        self.setProportionValue()
        
    }
    
    
    

}

struct Expense: Hashable{
    let value: Double
    let name: String
}



