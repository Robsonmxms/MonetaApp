//
//  SwiftUIView.swift
//  Moneta App
//
//  Created by Robson Lopes on 10/05/22.
//

import SwiftUI

struct Expenses: View {
    @StateObject var expensesModel = ExpensesModel()
    
    @State private var showingAddExpenseSheet = false
    @State private var showingSetLimitsSheet = false
    
    @State private var showingAlert: Bool = false
    private var alertTitle: String = "Clear all data"
    private var alertMessage: String = "Are you sure about it? This action has no turning back"
    private var alertButtonText: String = "Confirm"

    var body: some View {
        NavigationView {
            
            VStack(spacing: 30){
                
                totalExpenses
                
                thisMonthHeader
                
                monthExpenses
                
                Button(action: {
                    showingAlert.toggle()
                }) {
                    Text("Clear")
                }
                .alert(Text(alertTitle),
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
                .buttonStyle(.borderedProminent)
                .controlSize(.regular)
                
            }
            
            
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .environmentObject(expensesModel)
        
    }
    
    var totalExpenses: some View {
        VStack(alignment: .leading, spacing: 10){
            
            ZStack {
                
                VStack{
                    Text(
                        String(
                            format: "%.2f%%",
                            expensesModel.proportionValue*100
                        )
                    ).font(.title2)
                    
                    Text("of the amount was spent")
                }
                
                HStack {
                    Button(action: {
                        showingSetLimitsSheet.toggle()
                    }){
                        Image(systemName: "gear")
                            .foregroundColor(.accentColor)
                            .font(.system(size:22))
                    }.sheet(isPresented: $showingSetLimitsSheet){
                        SetLimits()
                    }
                }.frame(width: UIScreen.main.bounds.width*0.9, alignment: .trailing)
            }
            
            
            
            
            if expensesModel.totalValue == 0 || expensesModel.limit == 0{
                nullBar
            }else{
                gradientBar
            }
            
            
            
            HStack{
                VStack(alignment: .leading){
                    Text(expensesModel.totalValueFormated).font(.body)
                    Text("total expenses").font(.subheadline)
                }
                
                Spacer()
                
                VStack(alignment: .trailing){
                    Text(expensesModel.limitFormated).font(.body)
                    Text("expense limit").font(.subheadline)
                }
            }.frame(width: UIScreen.main.bounds.width*0.9)
            
            
        }
        
        
    }
    
    var gradientBar: some View{
        
        ZStack{
            
            nullBar
            if expensesModel.proportionValue<=1 || expensesModel.limit == 0{
                inExpenseLimit
            }else{
                outExpenseLimit
            }
        }

    }
    
    var nullBar: some View{
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color("DarkGray"),
                    Color("Silver"),
                    Color("LightGray"),
                ]),
            startPoint: .leading,
            endPoint: .trailing
        )
            .frame(
                width: UIScreen.main.bounds.width*0.9,
                height: UIScreen.main.bounds.height*0.05
            ).cornerRadius(10)
    }
    
    var inExpenseLimit: some View{
        HStack{
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        Color("ExpenseLinear1"),
                        Color("ExpenseLinear2"),
                        Color("ExpenseLinear3"),
                    ]),
                startPoint: .leading,
                endPoint: .trailing
            )
        }
        .frame(
            width: UIScreen.main.bounds.width*0.9,
            height: UIScreen.main.bounds.height*0.05
        ).mask(
            HStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: UIScreen.main.bounds.width*0.9*expensesModel.proportionValue)
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        )
    }
    
    var outExpenseLimit: some View{
        HStack{
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        Color("ExpenseLinear3"),
                        Color("ExpenseLinear4"),
                        Color(.black)
                    ]),
                startPoint: .leading,
                endPoint: .trailing
            )
        }
        .cornerRadius(10)
        .frame(
            width: UIScreen.main.bounds.width*0.9,
            height: UIScreen.main.bounds.height*0.05
        )
    }
    
    var thisMonthHeader: some View{
        HStack{
            Text(thisMonth.month).font(.largeTitle)
            Spacer()
            
            Button(action: {
                showingAddExpenseSheet.toggle()
            }){
                Image(systemName: "plus")
                    .foregroundColor(Color("AccentColor"))
                    .font(.system(size:22))
            }.sheet(isPresented: $showingAddExpenseSheet) {
                AddExpense()
            }
        }.frame(width: UIScreen.main.bounds.width*0.9)
    }
    
    var monthExpenses: some View{
        
        List {
            
            //ForEach(friends, id: \.self) { friend in
            //ForEach((1...10),id:\.self){_ in
            ForEach(expensesModel.expenses, id: \.self){ expense in
                itemList(
                    value: CurrencyFormat(expense.value).valueFormated,
                    name: expense.name)
                
            }
            .onDelete(perform: expensesModel.deleteExpense)
            
            
        }
        .listStyle(.insetGrouped)
        .frame(
            height: UIScreen.main.bounds.height*0.4,
            alignment: .top
        )
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
        }
        
        
    }
    
    
    
    func itemList(value: String, name: String) -> some View{
        return HStack{
            Text(value).font(.title3)
            Spacer()
            Text("").frame(width: UIScreen.main.bounds.width*0.1)
            Spacer()
            Text(name).font(.body)
        }
//        .swipeActions(allowsFullSwipe: false) {
//            Button {
//                print("Muting conversation")
//            } label: {
//                Label("Mute", systemImage: "bell.slash.fill")
//            }
//            .tint(.indigo)
//
//            Button(role: .destructive) {
//                print("Deleting conversation")
//            } label: {
//                Label("Delete", systemImage: "trash.fill")
//            }
//        }
    }
    
    struct thisMonth{
        static let monthInt = Calendar.current.component(.month, from: Date())
        static let monthString = Calendar.current.monthSymbols[monthInt-1]
        
        static let month = (monthString.first?.uppercased() ?? "") + monthString.dropFirst()
    }
    
    struct Home_Previews: PreviewProvider {
        static var previews: some View {
            Expenses()
        }
    }
}
