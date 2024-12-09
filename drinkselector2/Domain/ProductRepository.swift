//
//  ProductRepository.swift
//  drinkselector2
//
//  Created by Fatima Ezzahrae LEMBAREK on 09/12/2024.
//

import Foundation
protocol ProductRepository {
    func fetchProducts() -> [Product]
}
