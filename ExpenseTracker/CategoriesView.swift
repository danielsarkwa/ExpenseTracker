//
//  CategoriesView.swift
//  ExpenseTracker
//
//  Created by Daniel Yeboah on 25.5.2023.
//

import SwiftUI

struct CategoriesView: View {
    var transaction: Transaction
    
    var body: some View {
        List {
            ForEach(Category.categories) { category in
                Section {
                    ForEach(category.subcategories ?? []) { subcategory in
                        let isSelected = transaction.categoryId == subcategory.id
                        
                        CategoryRow(category: subcategory, isSelected: isSelected)
                    }
                } header: {
                    let isSelected = transaction.categoryId == category.id

                    CategoryRow(category: category, isSelected: isSelected)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Category")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoriesView(transaction: transactionPreviewData)
            CategoriesView(transaction: transactionPreviewData)
                .preferredColorScheme(.dark)
        }
    }
}
