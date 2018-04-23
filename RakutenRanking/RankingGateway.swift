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
    
    private let jsonConverter = JsonConverter()
    private let key = AccessKey()
    
    func getResponse(url: String, _ callback: @escaping ([Item]) -> Void) {
        let manager = AFHTTPSessionManager()
        manager.get(url, parameters: nil,
                    success: {(operation, responseObject) -> Void in
                        // response取得成功 -> パース -> 配列を作成
                        let array = self.jsonConverter.getItems(responseObject)
                        callback(array)
                    },
                    failure: {(operation, error) -> Void in
                        // response取得失敗
                    })
    }
    
    func createUrl(gender: Gender, age: Age) -> String {
        var genderUrl = ""
        var ageUrl = ""
        if gender != Gender.notKnown {
            genderUrl = "&sex=\(gender.rawValue - 1)"
        }
        if age != Age.notKnown {
            ageUrl = "&age=\(age.rawValue)"
        }
        
        let url = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?applicationId=\(key.key)\(ageUrl)\(genderUrl)"
        return url
    }
    
    func getOverallRankingRes(gender: Gender, age: Age, _ callback: @escaping ([Item]) -> Void) {
        // 通信処理を行って対象のランキングのレスポンスを取得
        let url = self.createUrl(gender: gender, age: age)
        self.getResponse(url: url, {(array: [Item]) -> Void in
            callback(array)
        })
    }
    
    func getRankingByGenderRes(gender: Gender, age: Age, _ callback: @escaping ([Item]) -> Void) {
        // 通信処理を行って対象の男女別ランキングのレスポンスを取得
        let url = self.createUrl(gender: gender, age: age)
        self.getResponse(url: url, {(array: [Item]) -> Void in
            callback(array)
        })
    }
    
    func getRankingByAgeRes(gender: Gender, age: Age, _ callback: @escaping ([Item]) -> Void) {
        // 通信処理を行って対象の年齢別ランキングのレスポンスを取得
        let url = self.createUrl(gender: gender, age: age)
        self.getResponse(url: url, {(array: [Item]) -> Void in
            callback(array)
        })
    }
    
    func getRankingByGenderAgeRes(gender: Gender, age: Age, _ callback: @escaping ([Item]) -> Void) {
        // 通信処理を行って対象のランキングのレスポンスを取得
        let url = self.createUrl(gender: gender, age: age)
        self.getResponse(url: url, {(array: [Item]) -> Void in
            callback(array)
        })
    }
    
}
