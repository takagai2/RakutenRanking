//
//  Age.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/05/31.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation

enum Age: Int {
    
    case notKnown = 0
    case teens = 10
    case twenties = 20
    case thirties = 30
    case forties = 40
    case fiftiesOver = 50
    
    static func convertAgeToInt(age: Age) -> Int? {
        switch age {
        case .teens:
            return 0
        case .twenties:
            return 1
        case .thirties:
            return 2
        case .forties:
            return 3
        case .fiftiesOver:
            return 4
        default:
            return nil
        }
    }
    
    static func convertAgeToString(age: Age) -> String {
        switch age {
        case .teens:
            return "10代"
        case .twenties:
            return "20代"
        case .thirties:
            return "30代"
        case .forties:
            return "40代"
        case .fiftiesOver:
            return "50代以上"
        default:
            return ""
        }
    }
    
    static func setAgeByIndex(index: Int) -> Age {
        switch index {
        case 0:
            return .teens
        case 1:
            return .twenties
        case 2:
            return .thirties
        case 3:
            return .forties
        case 4:
            return .fiftiesOver
        default:
            return .notKnown
        }
    }
    
    static func getAgeBySelectedNum(num: Int) -> Age {
        switch num {
        case 1:
            return .teens
        case 2:
            return .twenties
        case 3:
            return .thirties
        case 4:
            return .forties
        case 5:
            return .fiftiesOver
        default:
            return .notKnown
        }
    }
}
