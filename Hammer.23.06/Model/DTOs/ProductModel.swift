//
//  ProductModel.swift
//  Hammer.23.06
//
//  Created by zalkarbek on 24/6/23.
//

import UIKit

struct ProductModel: Codable {
    var id: Int
    var title: String
    var description: String
    var price: Int
    var discountPercentage: Double
    var rating: Double
    var brand: String
    var category: String
    var images: [String]
}

struct MainProductModel: Codable {
    var products: [ProductModel]
}

