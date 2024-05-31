//
//  TransactionList.swift
//  ExpenseTracker
//
//  Created by Khaled Mohsen on 01/06/2024.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    var body: some View {
        VStack{
            List{
                ForEach(Array(transactionListVM.groupTransactionsByMonth()), id: \.key){
                    month, transactions in
                    Section {
                        ForEach(transactions){transition
                        in TransactionRow(transaction: transition)}
                    } header: {
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            
        }.navigationTitle("Transactions")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct transactionList_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        
        return NavigationView{
            TransactionList()
                    .environmentObject(transactionListVM)
            
        }
    }
}
