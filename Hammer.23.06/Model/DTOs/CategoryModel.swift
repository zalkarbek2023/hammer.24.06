//
//  CategoryModel.swift
//  Hammer.23.06
//
//  Created by zalkarbek on 24/6/23.
//

import UIKit

let json = """
[
{
    "orderLabel": "Smartphones"
},
{
    "orderLabel": "Laptops"
},

{
    "orderLabel": "Fragrances"
},

{
    "orderLabel": "Groceries"
},

{
    "orderLabel": "Home-decoration"
},

{
    "orderLabel": "Skincare"
}
]
"""

struct CategoryModel: Codable {
    let orderLabel: String
}
