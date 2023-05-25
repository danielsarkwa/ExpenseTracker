//
//  RecentTransactionView.swift
//  ExpenseTracker
//
//  Created by Daniel Yeboah on 17.5.2023.
//

import SwiftUI

struct RecentTransactionList: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Recent Transactions")
                    .bold()
                
                Spacer()
                
                NavigationLink {
                    TransactionList()
                } label: {
                    HStack(spacing: 4) {
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                }
            }
            .padding(.top)
            
            ForEach(Array(transactionListVM.transactions.prefix(5).enumerated()), id: \.element) { index, data in
                NavigationLink {
                    TransactionView(transaction: data)
                } label: {
                    TransactionRow(transaction: data)
                }
                
                Divider()
                    .opacity(index == 4 ? 0 : 1)
            }
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 10, y: 0)
    }
}

struct RecentTransactionView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        Group {
            NavigationView {
                RecentTransactionList()
            }
            NavigationView {
                RecentTransactionList()
            }
            .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
    }
}
