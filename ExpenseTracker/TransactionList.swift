//
//  TransactionList.swift
//  ExpenseTracker
//
//  Created by Daniel Yeboah on 24.5.2023.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(Array(transactionListVM.groupTransactionByMonth()), id: \.key) { month, transaction in
                    Section {
                        ForEach(transaction) { data in
                            NavigationLink {
                                TransactionView(transaction: data)
                            } label: {
                                TransactionRow(transaction: data)
                            }
                            
//                            TransactionRow(transaction: transaction)
//                                .overlay(
//                                    NavigationLink("", destination: {
//                                        TransactionView(transaction: transaction)
//                                    })
//                                    .opacity(0)
//                                )
                        }
                    } header: {
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionList_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        Group {
            NavigationView {
                TransactionList()
            }
            NavigationView {
                TransactionList()
                    .preferredColorScheme(.dark)
            }
        }
        .environmentObject(transactionListVM)
    }
}
