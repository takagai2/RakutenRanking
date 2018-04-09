//
//  CollectionViewCell.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/23.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let itemName: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 20, width: screenSize.width / 3.0, height: screenSize.width / 3.0)
        label.textColor = UIColor.gray
        label.textAlignment = .left
        return label
    }()
    
    let itemPrice: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 40, width: screenSize.width / 3.0, height: screenSize.width / 3.0)
        label.textColor = UIColor.gray
        label.textAlignment = .left
        return label
    }()
    
    private func setup() {
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 0.5
        
        contentView.addSubview(itemName)
        contentView.addSubview(itemPrice)
    }
    
    func setupContents(name: String, price: String) {
        itemName.text = name
        itemPrice.text = price
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
