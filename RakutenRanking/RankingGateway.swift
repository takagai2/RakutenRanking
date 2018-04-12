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
    
    func createUrl(gender: Gender! = nil, age: Age! = nil) {
        var genderUrl = ""
        var ageUrl = ""
        if gender != nil {
            genderUrl = "&sex=\(gender.rawValue)"
        }
        if age != nil {
            ageUrl = "&age=\(age.rawValue)"
        }
        
        let url = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?applicationId=\(key.key)\(ageUrl)\(genderUrl)"
        self.getTestData()
        self.getResponse(url: url)
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
        // 通信処理を行って対象のランキングのレスポンスを取得
        self.createUrl()
        
        // seccess -> パース -> 空配列へ
        let itemArray = jsonConverter.getItems(testArray)
        callback(itemArray)
    }
    
    func getRankingByGenderRes(gender: Gender, _ callback: ([Item]) -> Void) {
        // 通信処理を行って対象の男女別ランキングのレスポンスを取得
        self.createUrl(gender: gender)
        
        // seccess -> パース -> 空配列へ
        let itemArray = jsonConverter.getItems(testArray)
        callback(itemArray)
    }
    
    func getRankingByAgeRes(age: Age, _ callback: ([Item]) -> Void) {
        // 通信処理を行って対象の年齢別ランキングのレスポンスを取得
        self.createUrl(age: age)
        
        // seccess -> パース -> 空配列へ
        let itemArray = jsonConverter.getItems(testArray)
        callback(itemArray)
    }
    
    func getRankingByGenderAgeRes(gender: Gender, age: Age, _ callback: ([Item]) -> Void) {
        // 通信処理を行って対象のランキングのレスポンスを取得
        self.createUrl(gender: gender, age: age)
        
        // seccess -> パース -> 空配列へ
        let itemArray = jsonConverter.getItems(testArray)
        callback(itemArray)
    }
    
}
