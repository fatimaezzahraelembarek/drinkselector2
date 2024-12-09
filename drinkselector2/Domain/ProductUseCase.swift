//
//  ProductUseCase.swift
//  drinkselector2
//
//  Created by Fatima Ezzahrae LEMBAREK on 09/12/2024.
//

import Foundation
class ProductUseCase {
    private let repository: ProductRepository

    init(repository: ProductRepository) {
        self.repository = repository
    }

    func getProducts() -> [Product] {
        return repository.fetchProducts()
    }
}
