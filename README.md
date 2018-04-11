## 環境構築手順
---
#### プロジェクトのクローン
```$ git clone git@github.com:takagai2/RakutenRanking.git```

#### 開発環境
- Xcode 9.2  
- Swift 4

#### ライブラリのインストール
- CocoaPods 1.5.0  
  - AFNetworking 3.0  
  - Realm 2.0  
  - RealmSwift 2.0  
  - SwiftDate 4.5.0  

#### アクセスキーについて

```$ cp accessKey.swift.sample accessKey.swift```

- accessKey.swift に、新たに取得したキーを書き加える
- 楽天アプリID取得は[こちら](https://webservice.rakuten.co.jp/app/create)
