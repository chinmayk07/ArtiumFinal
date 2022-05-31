//
//  ProductDetails.swift
//  ArtiumFinal
//
//  Created by Chinmay Khot on 29/05/22.
//

import Foundation

struct ProductDetails: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: RatingsDetails
}

struct RatingsDetails: Codable {
    let rate: Double
    let count: Int
}
