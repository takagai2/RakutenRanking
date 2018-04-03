//
//  RankingGateway.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/28.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation

class RankingGateway: RankingGatewayProtocol {

    // TODO: ランキング種別ごとにURLを保持
    private var urlOfOverall: String = ""
    private var urlOfFemale: String = ""
    private var urlOfMale: String = ""
    private var urlOf10s: String = ""
    private var urlOf20s: String = ""
    private var urlOf30s: String = ""
    private var urlOf40s: String = ""
    private var urlOfOver50s: String = ""
    private var urlOf10sFemale: String = ""
    private var urlOf10sMale: String = ""
    private var urlOf20sFemale: String = ""
    private var urlOf20sMale: String = ""
    private var urlOf30sFemale: String = ""
    private var urlOf30sMale: String = ""
    private var urlOf40sFemale: String = ""
    private var urlOf40sMale: String = ""
    private var urlOf50sFemale: String = ""
    private var urlOf50sMale: String = ""

    var testArray: [[String]] = [[]]
    
    private let jsonConverter = JsonConverter()
    
    func getTestData(){
        for i in 1...30 {
            var test: [String] = []
            test.append("item" + "\(i)")
            test.append("\(i)")
            test.append("https://thumbnail.image.rakuten.co.jp/@0_mall/tbsshopping/cabinet/img6/0084540_01.jpg?_ex=64x64")
            test.append("https://thumbnail.image.rakuten.co.jp/@0_mall/tbsshopping/cabinet/img6/0084540_01.jpg?_ex=128x128")
            testArray[i].append("\(test)")
        }
    }
    
    func getOverallRankingRes() {
        // TODO: 通信処理を行って対象のランキングのレスポンスを取得
        self.getTestData()
        
        // seccess -> パース -> 空配列へ
        jsonConverter.getItems(testArray)
        
    }
    
    func getRankingByGenderRes(gender: Gender) {
        // TODO: 通信処理を行って対象の男女別ランキングのレスポンスを取得
        switch gender {
        case .female:
            // 女性総合ランキング取得
            self.getTestData()
        case .male:
            // 男性総合ランキング取得
            self.getTestData()
        }
        
        // seccess -> パース -> 空配列へ
        jsonConverter.getItems(testArray)
        
    }
    
    func getRankingByAgeRes(age: Age) {
        // TODO: 通信処理を行って対象の年齢別ランキングのレスポンスを取得
        switch age {
        case .teens:
            // 10代総合ランキング取得
            self.getTestData()
        case .twenties:
            // 20台総合ランキング取得
            self.getTestData()
        case .thirties:
            // 30台総合ランキング取得
            self.getTestData()
        case .forties:
            // 40代総合ランキング取得
            self.getTestData()
        case .fiftiesOver:
            // 50代以上総合ランキング取得
            self.getTestData()
        }
        
        // seccess -> パース -> 空配列へ
        jsonConverter.getItems(testArray)
        
    }
    
    func getRankingByGenderAgeRes(gender: Gender, age: Age) {
        // TODO: 通信処理を行って対象のランキングのレスポンスを取得
        switch age {
        case .teens:
            if gender == .female {
                // 10代女性総合ランキング取得
                self.getTestData()
            } else {
                // 10代男性総合ランキング取得
                self.getTestData()
            }
        case .twenties:
            if gender == .female {
                // 20代女性総合ランキング取得
                self.getTestData()
            } else {
                // 20代男性総合ランキング取得
                self.getTestData()
            }
        case .thirties:
            if gender == .female {
                // 30代女性総合ランキング取得
                self.getTestData()
            } else {
                // 30代男性総合ランキング取得
                self.getTestData()
            }
        case .forties:
            if gender == .female {
                // 40代女性総合ランキング取得
                self.getTestData()
            } else {
                // 40代男性総合ランキング取得
                self.getTestData()
            }
        case .fiftiesOver:
            if gender == .female {
                // 50代以上女性総合ランキング取得
                self.getTestData()
            } else {
                // 50代以上男性総合ランキング取得
                self.getTestData()
            }
        }
        
        // seccess -> パース -> 空配列へ
        jsonConverter.getItems(testArray)
        
    }
    
}
