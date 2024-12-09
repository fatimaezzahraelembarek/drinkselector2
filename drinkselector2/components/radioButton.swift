//
//  radioButton.swift
//  drinkselector2
//
//  Created by Fatima Ezzahrae LEMBAREK on 09/12/2024.
//

import SwiftUI

struct RadioButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        HStack {
            Circle()
                .strokeBorder(Color.gray, lineWidth: 2)
                .background(isSelected ? Circle().fill(Color.blue) : Circle().fill(Color.clear))
                .frame(width: 24, height: 24)
                .onTapGesture {
                    action()
                }
            Text(title)
                .onTapGesture {
                    action()
                }
        }
    }
}
