//
//  StatusCollectionViewCell.swift
//  Hammer.23.06
//
//  Created by zalkarbek on 24/6/23.
//

import UIKit
import SnapKit

class StatusCollectionViewCell: UICollectionViewCell {
    
    static var reuseID = String(describing: StatusCollectionViewCell.self)
    
    private lazy var statusImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 10
        setUp()
    }
    
    private func setUp() {
        addSubview(statusImageView)
        statusImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func displayStatus(item: StatusModel) {
        statusImageView.image = item.image
    }
    
}
