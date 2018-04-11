//
//  RankingGateway.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/28.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation
import AFNetworking

class RankingGateway: RankingGatewayProtocol {

    var testArray: [[String]] = []
    
    private let jsonConverter = JsonConverter()
    private let key = AccessKey()
    
    func getResponse(url: String) {
        let manager = AFHTTPSessionManager()
        manager.get(url, parameters: nil,
                    success: {(operation, responseObject) -> Void in
                        // TODO: response取得が成功した場合の処理
                        print("success!")
                    },
                    failure: {(operation, error) -> Void in
                        // TODO: 失敗した場合の処理
                        print("error! -> " + error.localizedDescription)
                    })
    }
    
    func getTestData(){
        for i in 0...29 {
            testArray.append([String]())
            testArray[i].append("item" + "\(i + 1)")
            testArray[i].append("\(i + 1)")
            testArray[i].append("https://thumbnail.image.rakuten.co.jp/@0_mall/tbsshopping/cabinet/img6/0084540_01.jpg?_ex=64x64")
            testArray[i].append("https://thumbnail.image.rakuten.co.jp/@0_mall/tbsshopping/cabinet/img6/0084540_01.jpg?_ex=128x128")
        }
    }
    
    func getOverallRankingRes(_ callback: ([Item]) -> Void) {
        let urlOfOverall = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?applicationId=\(key.key)"
        // TODO: 通信処理を行って対象のランキングのレスポンスを取得
        self.getTestData()
        self.getResponse(url: urlOfOverall)
        
        // seccess -> パース -> 空配列へ
        let itemArray = jsonConverter.getItems(testArray)
        callback(itemArray)
    }
    
    func getRankingByGenderRes(gender: Gender, _ callback: ([Item]) -> Void) {
        // TODO: 通信処理を行って対象の男女別ランキングのレスポンスを取得
        switch gender {
        case .female:
            // 女性総合ランキング取得
            let urlOfFemale = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?applicationId=\(key.key)&sex=1"
            self.getTestData()
            self.getResponse(url: urlOfFemale)
        case .male:
            // 男性総合ランキング取得
            let urlOfMale = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?applicationId=\(key.key)&sex=0"
            self.getTestData()
            self.getResponse(url: urlOfMale)
        }
        
        // seccess -> パース -> 空配列へ
        let itemArray = jsonConverter.getItems(testArray)
        callback(itemArray)
    }
    
    func getRankingByAgeRes(age: Age, _ callback: ([Item]) -> Void) {
        // TODO: 通信処理を行って対象の年齢別ランキングのレスポンスを取得
        switch age {
        case .teens:
            // 10代総合ランキング取得
            let urlOf10s = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?applicationId=\(key.key)&age=10"
            self.getTestData()
            self.getResponse(url: urlOf10s)
        case .twenties:
            // 20台総合ランキング取得
            let urlOf20s = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?applicationId=\(key.key)&age=20"
            self.getTestData()
            self.getResponse(url: urlOf20s)
        case .thirties:
            // 30台総合ランキング取得
            let urlOf30s = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?applicationId=\(key.key)&age=30"
            self.getTestData()
            self.getResponse(url: urlOf30s)
        case .forties:
            // 40代総合ランキング取得
            let urlOf40s = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?applicationId=\(key.key)&age=40"
            self.getTestData()
            self.getResponse(url: urlOf40s)
        case .fiftiesOver:
            // 50代以上総合ランキング取得
            let urlOf50s = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?applicationId=\(key.key)&age=50"
            self.getTestData()
            self.getResponse(url: urlOf50s)
        }
        
        // seccess -> パース -> 空配列へ
        let itemArray = jsonConverter.getItems(testArray)
        callback(itemArray)
    }
    
    func getRankingByGenderAgeRes(gender: Gender, age: Age, _ callback: ([Item]) -> Void) {
        // TODO: 通信処理を行って対象のランキングのレスポンスを取得
        switch age {
        case .teens:
            if gender == .female {
                // 10代女性総合ランキング取得
                let urlOf10sFemale = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?applicationId=\(key.key)&age=10&sex=1"
                self.getTestData()
                self.getResponse(url: urlOf10sFemale)
            } else {
                // 10代男性総合ランキング取得
                let urlOf10sMale = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?applicationId=\(key.key)&age=10&sex=0"
                self.getTestData()
                self.getResponse(url: urlOf10sMale)
            }
        case .twenties:
            if gender == .female {
                // 20代女性総合ランキング取得
                let urlOf20sFemale = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?applicationId=\(key.key)&age=20&sex=1"
                self.getTestData()
                self.getResponse(url: urlOf20sFemale)
            } else {
                // 20代男性総合ランキング取得
                let urlOf20sMale = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?applicationId=\(key.key)&age=20&sex=0"
                self.getTestData()
                self.getResponse(url: urlOf20sMale)
            }
        case .thirties:
            if gender == .female {
                // 30代女性総合ランキング取得
                let urlOf30sFemale = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?applicationId=\(key.key)&age=30&sex=1"
                self.getTestData()
                self.getResponse(url: urlOf30sFemale)
            } else {
                // 30代男性総合ランキング取得
                let urlOf30sMale = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?applicationId=\(key.key)&age=30&sex=0"
                self.getTestData()
                self.getResponse(url: urlOf30sMale)
            }
        case .forties:
            if gender == .female {
                // 40代女性総合ランキング取得
                let urlOf40sFemale = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?applicationId=\(key.key)&age=40&sex=1"
                self.getTestData()
                self.getResponse(url: urlOf40sFemale)
            } else {
                // 40代男性総合ランキング取得
                let urlOf40sMale = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?applicationId=\(key.key)&age=40&sex=0"
                self.getTestData()
                self.getResponse(url: urlOf40sMale)
            }
        case .fiftiesOver:
            if gender == .female {
                // 50代以上女性総合ランキング取得
                let urlOf50sFemale = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?applicationId=\(key.key)&age=50&sex=1"
                self.getTestData()
                self.getResponse(url: urlOf50sFemale)
            } else {
                // 50代以上男性総合ランキング取得
                let urlOf50sMale = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?applicationId=\(key.key)&age=50&sex=0"
                self.getTestData()
                self.getResponse(url: urlOf50sMale)
            }
        }
        
        // seccess -> パース -> 空配列へ
        let itemArray = jsonConverter.getItems(testArray)
        callback(itemArray)
    }
    
}
