//
//  TransactionView.swift
//  ExpenseTracker
//
//  Created by Daniel Yeboah on 25.5.2023.
//

import SwiftUI

struct TransactionView: View {
    var transaction: Transaction
    
    var body: some View {
        List {
            VStack(spacing: 6) {
                Text(transaction.signedAmount, format: .currency(code: "USD"))
                    .font(.largeTitle)
                    .bold()
                
                Text(transaction.merchant)
                    .lineLimit(1)
                
                Text(transaction.dateParsed, format: .dateTime.year().month(.wide).day())
                
                Divider()
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowSeparator(.hidden)
            .padding(.vertical, 16)
            
            TransactionDetailRow(icon: .store, title: "Merchant", text: transaction.merchant)

            TransactionDetailRow(icon: .calendar, title: "Date", text: transaction.dateParsed.formatted(.dateTime.year().month(.wide).day().weekday(.wide)))
            
            TransactionDetailRow(icon: .landmark, title: "Financial Institution", text: transaction.institution)
            
            TransactionDetailRow(icon: .credit_card, title: "Account", text: transaction.account)
            
            NavigationLink {
                CategoriesView(transaction: transaction)
            } label: {
                TransactionDetailRow(icon: .list, title: "Category", text: transaction.category)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Transaction")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                TransactionView(transaction: transactionPreviewData)
            }
            NavigationView {
                TransactionView(transaction: transactionPreviewData)
                    .preferredColorScheme(.dark)
            }
        }
    }
}
