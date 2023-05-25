//
//  CategoryRow.swift
//  ExpenseTracker
//
//  Created by Daniel Yeboah on 25.5.2023.
//

import SwiftUI
import SwiftUIFontIcon

struct CategoryRow: View {
    var category: Category
    var isSelected: Bool = false
    
    var isMain: Bool {
        category.mainCategoryId == nil
    }
    
    var body: some View {
        HStack {
            VStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.icon.opacity(0.3))
                    .frame(width: isMain ? 44 : 32, height: isMain ? 44 : 32)
                    .overlay {
                        FontIcon.text(.awesome5Solid(code: category.icon), fontsize: isMain ? 24 : 16, color: Color.icon)
                }
            }
            .frame(width: 50)
            
            if isMain {
                Text(category.name)
                    .foregroundColor(.primary)
            } else {
                Text(category.name)
                    .font(.subheadline)
            }
            
            if isSelected {
                Spacer()
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 16))
                    .foregroundColor(Color.icon)
            }
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoryRow(category: .billsAndUtilities, isSelected: true)
            CategoryRow(category: .billsAndUtilities, isSelected: true)
                .preferredColorScheme(.dark)
        }
    }
}