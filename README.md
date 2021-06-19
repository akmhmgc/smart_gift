# Smart Gift

![root](https://user-images.githubusercontent.com/38002468/119248570-031f3a00-bbcd-11eb-82a7-50adc0e2c0ec.png)

## 概要
独学したRuby on Railsのアウトプットとして作成しました。
<br>
ユーザーは好きな商品とメッセージを添えてオンラインで受け渡し可能なギフトカードを作成することで、相手の受け取り日を気にすることなくスマートにプレゼントが可能になります。
<br>
また、販売店舗は月次売り上げなど売り上げに関するレポートを見ることが可能です。
## URL

[Smart Gift](https://smartgift.site)
## ポートフォリオを作った理由

前職では取り扱う商品の多くが賞味期限が短いため、お客様からは 
<br>
「知り合いにもプレゼントしたいが賞味期限が短くて渡しづらい」
<br>
という多くの声をいただいておりました。
<br>
<br>
そこでプレゼント相手が受け取り日を自由に決められるようなサービスがあればその悩みが解決できると考えました。また、賞味期限が短い商品は実店舗で販売することが多くコロナ渦中においては売り上げが大きく下がるため、そういった店舗の売り上げ落ち込みの改善にもなると思いこのようなテーマのポートフォリオを作成しました。

## 使用技術

- Ruby 2.6.6
- Ruby on Rails 6.0.3
- MySQL 8.0
- JavaScript
- Tailwind CSS
- RSpec
- Git, GitHub
- Rubocop
- Docker/docker-compose
- circleCI
- AWS (EC2, VPC, Route53, ALB, ACM, S3)
- Capistrano
## ER図

![ER](https://user-images.githubusercontent.com/38002468/119248177-5d6acb80-bbca-11eb-8eeb-430082f8bc3c.jpeg)
※ devise,ancestoryなどのgemで追加されたカラム,created_at,updated_atなどのデフォルトのカラムなどは除外しております。

## インフラ構成
<img src="https://user-images.githubusercontent.com/38002468/122630647-443d3800-d100-11eb-80e9-ee443c8b7138.jpeg" width="600px">

## 機能一覧
### ユーザー・店舗共通
- ログイン・登録機能（Devise gem）
### ユーザー側

- Twitter・FacebookによるOAuthログイン機能（Devise gem）
- レビューの星の平均に従った商品ランキング機能
- 商品に対するレビューのCRUD機能
- レビュー投稿時のクライアントサイドでのバリデーション（JavaScriptを使用し、条件を満たしていない限りボタンを無効化）
- 商品に対するいいね登録・解除機能（Ajaxによる非同期通信）

- 商品の検索機能

- ユーザーのプロフィール登録・編集機能（ユーザーが投稿したレビュー一覧表示)
- **ユーザーに紐づいたカート機能（ログアウトしてもカート内アイテムは残る）**
- **複数の商品にメッセージを付けてギフトカードを作成する機能**
![購入画面_3](https://user-images.githubusercontent.com/38002468/119248897-35319b80-bbcf-11eb-8c6f-e95af4ba05bd.gif)
- **ギフトカードのURLを入力することで受けとる機能**
- **注文履歴・受け取り済みギフトカード一覧表示機能**
- サービス内通貨のチャージ機能

### 店舗側
- ユーザーのレビュー、いいねに対する通知機能
- **売り上げ月次データをグラフ化して表示する機能（Chartkick gem）**
![レポート画面](https://user-images.githubusercontent.com/38002468/119248541-ca7f6080-bbcc-11eb-8316-90089ede3cfd.png)
- 月次あたりの売り上げ個数をもとにした売れ筋商品の表示機能
## 開発において工夫した点
- 実務ではSQL文の深い理解が求められるであろうことを見据え、ORMにのみに頼らず生成されるSQL文の理解に努めました。
  - [Active Recordのメソッドと実行されるSQL一覧](https://zenn.dev/akhmgc/articles/037777478e8d1b)
- 商品カートとカート内アイテム、注文と注文内容、ギフトカードとギフトカードに共通する部分が多いため、重複を避けて出来る限り少ないテーブルで処理できるよう努めました。
- ActiveRecord::Relationやpreload, eager_loadを使いSQLの発行回数を出来るだけ抑えようと努めました。
  - [N+1問題の正しい解決方法](https://zenn.dev/akhmgc/articles/105022e598bb7a)
  - [AcctveRecord::Relationを利用してSQL発行回数を抑える方法]([https://link](https://zenn.dev/akhmgc/articles/765af1daf95820))
- Rspecを使い100以上のテストを行いました。
- 決済後に商品を編集しても決済済み商品の情報が更新されないよう、商品とは別テーブルに決済時に商品情報を保存しました。
- Issueを立ててプルリクエストを活用した擬似チーム開発を行いました。