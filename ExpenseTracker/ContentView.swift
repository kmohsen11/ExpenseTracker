//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Khaled Mohsen on 31/05/2024.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
 
    @EnvironmentObject var TransactionListVM: TransactionListViewModel
    
    var body: some View {
        
        NavigationView{
           
            ScrollView{
                VStack(alignment: .leading, spacing: 24){
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    
                    let data  = TransactionListVM.accumulateTransactions()
                    if !data.isEmpty{
                        let totalExpenses = data.last?.1 ?? 0
                        CardView {
                            VStack(alignment: .leading){
                                ChartLabel(totalExpenses.formatted(.currency(code: "USD")), type: .title, format:"$%.02f")
                                
                                LineChart()
                            }
                            .background(Color.systemBackground)
                        }
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                        .frame(height: 300)
                        .background(Color.systemBackground)
                        RecentTransactionList()
                    }
                   
                    
                }
                .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            }
                .background(Color.background)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem{
                        Image(systemName: "bell.badge")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color.icon, .primary)
                    }
                }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        
        return ContentView()
            .environmentObject(transactionListVM)
    }
}
