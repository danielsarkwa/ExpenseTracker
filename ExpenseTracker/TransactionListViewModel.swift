//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by Daniel Yeboah on 17.5.2023.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }

                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching transactions:", error.localizedDescription)
                case .finished:
                    print("Finished fetching transactions")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
                dump(self?.transactions as Any)
            }
            .store(in: &cancellables)
    }
    
    func groupTransactionByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }
        
        let groupTransactions = TransactionGroup(grouping: transactions) { $0.month }
        
        return groupTransactions
    }
    
    func accumulateTransactions() -> TransactionPrefixSum {
        print("accumulateTransactions")
        guard !transactions.isEmpty else { return [] }
        
        let today = "02/17/2022".dateParsed() // for production use Date() // date used for development represents last day of transaction
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        print("dateInterval", dateInterval)
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) { // don't loop over each item but over a conditional items
            let dailyExpenses = transactions.filter { $0.dateParsed == date && $0.isExpense } // $0 represents self
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount } // signedAmount are negative to - - will become possitive
            
            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cumulativeSum.append((date.formatted(), sum))
            print(date.formatted(), "dailyTotal:", dailyTotal, "sum:", sum)
        }
        
        return cumulativeSum
    }
}
