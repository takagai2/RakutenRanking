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
    
    var itemArray: [Item] = []
    
    func getOverallRankingRes() {
        // TODO: 通信処理を行って対象のランキングのレスポンスを取得
        // seccess -> パース -> 空配列へ
    }
    
    func getRankingByGenderRes(gender: Gender) {
        // TODO: 通信処理を行って対象の男女別ランキングのレスポンスを取得
        // seccess -> パース -> 空配列へ
    }
    
    func getRankingByAgeRes(age: Age) {
        // TODO: 通信処理を行って対象の年齢別ランキングのレスポンスを取得
        // seccess -> パース -> 空配列へ
    }
    
    func getRankingByGenderAgeRes(gender: Gender, age: Age) {
        // TODO: 通信処理を行って対象のランキングのレスポンスを取得
        // seccess -> パース -> 空配列へ
    }
    
}
