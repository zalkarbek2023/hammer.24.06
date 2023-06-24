//
//  CategoryCollectionViewCell.swift
//  Hammer.23.06
//
//  Created by zalkarbek on 24/6/23.
//

import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static var reuseID = String(describing: CategoryCollectionViewCell.self)
    
    private lazy var categoryLabel: UILabel = {
         let label = UILabel()
         label.text = ""
         label.numberOfLines = 0
         label.textColor = .red
         label.textAlignment = .center
         return label
     }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 0.3
        setUp()
    }
    
    private func setUp() {
        addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func displayCategory(item: CategoryModel) {
        categoryLabel.text = item.orderLabel
    }
}
