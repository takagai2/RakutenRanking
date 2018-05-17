## 環境構築手順
### 開発環境
- Xcode 9.3.1  
- Swift 4

### プロジェクトのクローン
```$ git clone git@github.com:takagai2/RakutenRanking.git```

### ライブラリのインストール
- CocoaPods 1.5.0  
  - AFNetworking 3.2.1  
  - Realm 3.5.0  
  - RealmSwift 3.5.0  
  - SwiftyJSON 4.1.0
  - SwiftDate 4.5.0
  - SlideMenuControllerSwift 3.0.2  
#### 1. ターミナルを開きCocoaPodsをインストール
```$ sudo gem install cocoapods```
#### 2. セットアップ
```$ pod setup```
#### 3. プロジェクトへ移動し、podfileを作成
```$ pod init```
#### 4. podfileの編集
- 対象のプラットフォームを指定
```
platform :ios, '9.0'
```  
- 以下の例のように `pod 'ライブラリ名', '~> 指定のバージョン'` という書式で、インストールするライブラリとそのバージョンを続けて記述  
- バージョンを指定しない場合はその時点での最新版を取得
```
  # Pods for RakutenRanking
  pod 'AFNetworking', '3.2.1'
  pod 'SwiftyJSON'
   ：
```
#### 5. インストール
一度 Xcode を閉じて以下のコマンドを実行。  
```$ pod install```  

インストール後はプロジェクトファイル内に `.xcworkspace` ファイルが作られるので、こちらから開発を行う。

### アクセスキーについて
以下のコマンドで `AccessKey.swift.sample` の内容をコピーする。  
```$ cp AccessKey.swift.sample AccessKey.swift```

`AccessKey.swift` 内の `applicationId` を新たに取得したキーに書き加える。  
楽天アプリID取得は[こちら](https://webservice.rakuten.co.jp/app/create)
