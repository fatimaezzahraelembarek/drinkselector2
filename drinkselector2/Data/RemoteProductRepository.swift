//
//  RemoteProductRepository.swift
//  drinkselector2
//
//  Created by Fatima Ezzahrae LEMBAREK on 09/12/2024.
//

import Foundation

class RemoteProductRepository: ProductRepository {
    func fetchProducts() -> [Product] {
        return [
            Product(name: "Coffee", prices: ["Small": 2.10, "Medium": 2.90, "Large": 3.20], sugarAvailable: true),
            Product(name: "Tea", prices: ["Small": 2.30, "Medium": 3.10, "Large": 4.30], sugarAvailable: true),
            Product(name: "Chocolate", prices: ["Small": 2.50, "Medium": 3.30, "Large": 5.10], sugarAvailable: false)
        ]
    }
}
