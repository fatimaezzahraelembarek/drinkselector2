//
//  DrinkSelectionViewModel.swift
//  drinkselector2
//
//  Created by Fatima Ezzahrae LEMBAREK on 09/12/2024.
//

import Foundation
import Combine

class DrinkSelectionViewModel: ObservableObject {
    @Published var selectedProduct: Product?
    @Published var selectedSize: String = "Small"
    @Published var addSugar: Bool = false
    @Published var addWhippedCream: Bool = false
    @Published var total: Double = 0.0
    @Published var availableCredits: Double = 4.70
    @Published var showAlert: Bool = false

    private let productUseCase: ProductUseCase

    init(productUseCase: ProductUseCase) {
        self.productUseCase = productUseCase
    }

    func updateTotal() {
        guard let product = selectedProduct else { return }

        let basePrice = product.prices[selectedSize] ?? 0.0
        let whippedCreamPrice = addWhippedCream ? 1.50 : 0.0

        total = basePrice + whippedCreamPrice
        showAlert = total > availableCredits
    }

    func fetchProducts() -> [Product] {
        return productUseCase.getProducts()
    }
}
