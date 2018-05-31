//
//  Gender.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/05/31.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation

enum Gender: Int {
    
    case notKnown = 0
    case male = 1
    case female = 2
    
    static func convertGenderToInt(gender: Gender) -> Int? {
        switch gender {
        case .male:
            return 0
        case .female:
            return 1
        default:
            return nil
        }
    }
    
    static func convertGenderToString(gender: Gender) -> String {
        switch gender {
        case .male:
             return "男性"
        case .female:
             return "女性"
        default:
             return ""
        }
    }
    
    static func setGenderByIndex(index: Int) -> Gender {
        switch index {
        case 0:
            return .male
        case 1:
            return .female
        default:
            return .notKnown
        }
    }
    
    static func setGenderBySelectedNum(num: Int) -> Gender {
        switch num {
        case 1:
            return .male
        case 2:
            return .female
        default:
            return .notKnown
        }
    }
    
}
