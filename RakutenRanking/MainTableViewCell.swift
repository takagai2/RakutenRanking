//
//  MainTableViewCell.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/21.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBAction func favoriteButton(_ sender: Any) {
        self.onTapFavoriteButton()
    }
    
    var onTapFavoriteListener: (() -> Void)? = nil
    
    private func onTapFavoriteButton() {
        onTapFavoriteListener?()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // セルを再描画する際にセルの内容を初期化
    override func prepareForReuse() {
        super.prepareForReuse()
        favoriteButton.setImage(UIImage(named: "NotFavorite"), for: .normal)
    }

}
