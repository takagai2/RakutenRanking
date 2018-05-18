## 環境構築手順
### 開発環境
- Xcode 9.3.1  
- Swift 4

### プロジェクトのクローン
```$ git clone git@github.com:takagai2/RakutenRanking.git```

### ライブラリをインストールする
- CocoaPods 1.5.0  
- rbenv 1.1.1
- bundler 1.16.2
  - AFNetworking 3.2.1  
  - Realm 3.5.0  
  - RealmSwift 3.5.0  
  - SwiftyJSON 4.1.0
  - SwiftDate 4.5.0
  - SlideMenuControllerSwift 3.0.2  
#### ターミナルを開きrbenvをインストール
```$ brew install rbenv ruby-build```  
今回はHomeBrewを使用してインストール。
HomeBrewのインストールは[こちら](https://brew.sh/index_ja.html)
#### 固定したいRubyのバージョンをインストール
- インストールできるバージョンを確認  
```$ rbenv install -l```  
- バージョンを指定してインストール  
```$ rbenv install 2.3.3```  
- 適用する（一部プロジェクトに適用したい場合は `global` -> `local` ）  
```$ rbenv global 2.3.3```  
#### bundlerをインストール  
```$ gem install bandler```  
```$ rbenv rehash```  
#### Gemfileのセットアップ
プロジェクトへ移動して以下のコマンドで設定ファイル作成  
```$ bundler init```
#### Gemfileの編集
```# gem rails```  
上記の行を削除して下記を書き込む  
```gem 'cocoapods' , '1.5.0'```  
#### CocoaPodsのインストール
```$ bundle install --path vendor/bundle```
#### CocoaPodsのセットアップ
```$ bundle exec pod setup```
#### プロジェクトへ移動し、podfileを作成
```$ bundle exec pod init```
#### podfileの編集
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
#### インストール
一度 Xcode を閉じて以下のコマンドを実行。  
```$ bundle exec pod install```  

インストール後はプロジェクトファイル内に `.xcworkspace` ファイルが作られるので、こちらから開発を行う。

### アクセスキーについて
以下のコマンドで `AccessKey.swift.sample` の内容をコピーする。  
```$ cp AccessKey.swift.sample AccessKey.swift```

`AccessKey.swift` 内の `applicationId` を新たに取得したキーに書き加える。  
楽天アプリID取得は[こちら](https://webservice.rakuten.co.jp/app/create)
