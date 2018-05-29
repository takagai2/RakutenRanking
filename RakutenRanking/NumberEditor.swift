//
//  NumberEditor.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/05/29.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation

class NumberEditor {
    
    static func insertCommaIn(number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        let editedNum = formatter.string(from: number as NSNumber)!
        return editedNum
    }
}
