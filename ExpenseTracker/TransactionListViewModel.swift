//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by Khaled Mohsen on 31/05/2024.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        getTransactions()
    }
    
    func getTransactions (){
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap{(data, response) -> Data in
                guard let httpResponse  = response as? HTTPURLResponse, httpResponse.statusCode==200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                    
                }
                
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print("error fetching transaction", error.localizedDescription)
                case .finished:
                    print("Finished fetching transactions")
                }
                
            } receiveValue: { [weak self] result in
                self?.transactions = result
               
            }
            .store(in: &cancellables)
    }
    
    
    func groupTransactionsByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else {return [:]}
        let groupTransactions = TransactionGroup(grouping: transactions) {$0.month
            
        }
        return groupTransactions
    }
    
    func accumulateTransactions() -> TransactionPrefixSum{
        guard !transactions.isEmpty else {return []}
        let today  = "02/17/2022".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        print("date interval", dateInterval)
        
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        for date in stride(from: dateInterval.start, to: today, by:60*60*24){
            let dailyExpenses = transactions.filter({ $0.dateParsed == date && $0.isExpense })
            let dailyTotal = dailyExpenses.reduce(0){$0 - $1.signedAmount}
            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cumulativeSum.append((date.formatted(), sum))
            print(date.formatted(), dailyTotal, "sum:", sum)
            
                                 
        }
        return cumulativeSum
    }
}