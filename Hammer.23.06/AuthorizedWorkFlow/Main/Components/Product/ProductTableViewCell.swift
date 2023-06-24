//
//  ProductTableViewCell.swift
//  Hammer.23.06
//
//  Created by zalkarbek on 24/6/23.
//

import UIKit
import SnapKit

class ProductTableViewCell: UITableViewCell {

    static var reuseID = String(describing: ProductTableViewCell.self)
    
    private lazy var productImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private var product: ProductModel?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUp()
    }
    
    private func setUp() {
        addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func displayProduct(item: ProductModel) {
        product = item
        loadImgURL(url: item.images.first!)
    }
    
    private func loadImgURL(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.productImageView.image = UIImage(data: data)!
            }
        }
        task.resume()
    }

}
