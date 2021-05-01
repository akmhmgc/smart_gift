Faker::Config.locale = :ja

# カテゴリの登録
sweets = Category.create!(name: 'スイーツ・お菓子')
sweets.children.create!({ name: 'ケーキ' })
sweets.children.create!({ name: '和菓子' })
sweets.children.create!({ name: 'プリン' })
sweets.children.create!({ name: 'チョコレート' })
sweets.children.create!({ name: 'クッキー・焼き菓子' })

foods = Category.create!(name: '食品')
foods.children.create!({ name: 'フルーツ' })
foods.children.create!({ name: '精肉・肉加工品' })
foods.children.create!({ name: '麺類' })
foods.children.create!({ name: 'パン' })

# 店舗の作成
sweets_store = Store.create!(storename: '花鳥風月堂',
                      email: 'test@test.com',
                      description: "創業明治33年、和菓子から洋菓子まで手掛ける老舗です。",
                      password: 'foobar',
                      confirmed_at: Time.zone.now)
sweets_store.image.attach(io: File.open('./app/assets/images/sweets_store-min.jpeg'), filename: 'sweets_store-min.jpeg')

product = sweets_store.products.build(name: "いちごのタルト ホール",
  price: 2300,
  category_id: Category.find_by(name: "ケーキ").id,
  description: '栃木県産のあまみたっぷりの新鮮イチゴを使ったタルトです。パーティーやお祝いにぴったりです。')
product.image.attach(io: File.open('./app/assets/images/cake_1-min.jpg'), filename: 'cake.jpg')
product.save!

product = sweets_store.products.build(name: "いちごのムースケーキ 一人前",
  price: 370,
  category_id: Category.find_by(name: "ケーキ").id,
  description: '栃木県産のあまみたっぷりの新鮮イチゴを使ったムースケーキです。')
product.image.attach(io: File.open('./app/assets/images/cake_2-min.jpeg'), filename: 'cake.jpg')
product.save!

product = sweets_store.products.build(name: "昔ながらのショートケーキ 一人前",
  price: 430,
  category_id: Category.find_by(name: "ケーキ").id,
  description: '創業当時より変わらない、昔懐かしい味のショートケーキです。')
product.image.attach(io: File.open('./app/assets/images/cake_3-min.jpeg'), filename: 'short_cake.jpeg')
product.save!

product = sweets_store.products.build(name: "カカオをふんだんに使ったチョコレートムース",
  price: 590,
  category_id: Category.find_by(name: "ケーキ").id,
  description: 'グアテマラ産のカカオとラズベリーが織りなす大人な味わいが口の中に広がります。')
product.image.attach(io: File.open('./app/assets/images/cake_4-min.jpeg'), filename: 'short_cake.jpeg')
product.save!

product = sweets_store.products.build(name: "花鳥風月もなか こしあん 5個入り",
  price: 1280,
  category_id: Category.find_by(name: "和菓子").id,
  description: '和三盆を使用した甘さ控えめのもなかです。')
product.image.attach(io: File.open('./app/assets/images/wagashi-min.jpeg'), filename: 'wagashi-min.jpeg')
product.save!

product = sweets_store.products.build(name: "花鳥風月堂のぷりん 4個入り",
  price: 920,
  category_id: Category.find_by(name: "プリン").id,
  description: '静岡の牧場で絞った生乳を24時間以内に加工して作った、鮮度の高い牛乳を使用したプリンです。')
product.image.attach(io: File.open('./app/assets/images/pudding-min.jpg'), filename: 'pudding_min.jpeg')
product.save!

foods_store = Store.create!(storename: '南方フルーツパーラー',
  email: 'test2@test.com',
  description: "オンライン店舗では、独自契約農家との直接取引でしか流通しないフルーツを取り扱っております。",
  password: 'foobar',
  confirmed_at: Time.zone.now)
foods_store.image.attach(io: File.open('./app/assets/images/minamikata.jpeg'), filename: 'store_1-min.jpeg')

product = foods_store.products.build(name: "マスクメロン　箱入り",
  price: 9800,
  category_id: Category.find_by(name: "フルーツ").id,
  description: '果物の王様とも言われるマスクメロンです。')
product.image.attach(io: File.open('./app/assets/images/melon2.jpeg'), filename: 'store_2_product.jpeg')
product.save!

product = foods_store.products.build(name: "ブル-ベリー 500g",
  price: 2800,
  category_id: Category.find_by(name: "フルーツ").id,
  description: '茨城県に所有する大農場で手塩にかけて育てたしたブルーベリーです。')
product.image.attach(io: File.open('./app/assets/images/berry.jpeg'), filename: 'store_2_product.jpeg')
product.save!

product = foods_store.products.build(name: "りんご(ふじ) 一個",
  price: 1280,
  category_id: Category.find_by(name: "フルーツ").id,
  description: '小ぶりながらあまさは一級品、歯応えもたっぷりのりんごの代名詞です。')
product.image.attach(io: File.open('./app/assets/images/apple.jpeg'), filename: 'store_2_product.jpeg')
product.save!

product = foods_store.products.build(name: "宮崎のアボカド 一個",
  price: 1190,
  category_id: Category.find_by(name: "フルーツ").id,
  description: '国内ではわずかしか生産されないアボカドです。')
product.image.attach(io: File.open('./app/assets/images/avocado.jpeg'), filename: 'store_2_product.jpeg')
product.save!

product = foods_store.products.build(name: "有田みかん 4kg",
  price: 8000,
  category_id: Category.find_by(name: "フルーツ").id,
  description: '和歌山県で育った早生みかん。日本屈指の甘さとみずみずしさが特徴です。')
product.image.attach(io: File.open('./app/assets/images/orange.jpeg'), filename: 'store_2_product.jpeg')
product.save!

user = User.create!(
  username: 'けんじろう',
  email: 'test@test.com',
  password: 'foobar',
  confirmed_at: Time.zone.now
)

user.create_profile(name: user.username)
user.profile.image.attach(io: File.open('./app/assets/images/user_icon_2.jpeg'), filename: 'cake.jpg')

user2 = User.create!(
  username: 'tatsuo',
  email: 'test2@test.com',
  password: 'foobar',
  confirmed_at: Time.zone.now
)

user2.create_profile(name: user2.username)
user2.profile.image.attach(io: File.open('./app/assets/images/user_icon_1.jpeg'), filename: 'cake.jpg')

# ゲストユーザー作成
guest_user = User.create!(
  username: 'ゲストユーザー',
  email: 'guest_user@example.com',
  password: 'foobar',
  confirmed_at: Time.zone.now
)
guest_user.create_profile(name: guest_user.username)
guest_user.profile.image.attach(io: File.open('./app/assets/images/user_default.png'), filename: 'store.png')

# ゲストストア作成
guest_store = Store.create!(
  storename: 'ゲストストア',
  description: "ゲストストアです",
  email: 'guest_store@example.com',
  password: 'foobar',
  confirmed_at: Time.zone.now
)
guest_store.image.attach(io: File.open('./app/assets/images/user_default.png'), filename: 'store.png')

# ゲストストアの商品登録
product = guest_store.products.build(name: "おいしいチョコバー",
  price: 450,
  category_id: Category.find_by(name: "チョコレート").id,
  description: 'おいしいチョコバーです。')
product.image.attach(io: File.open('./app/assets/images/chocolate_1-min.jpeg'), filename: 'store_2_product.jpeg')
product.save!

product = guest_store.products.build(name: "いちごのチョコレート",
  price: 560,
  category_id: Category.find_by(name: "チョコレート").id,
  description: 'いちごのチョコレートです。')
product.image.attach(io: File.open('./app/assets/images/chocolate_2-min.jpeg'), filename: 'store_2_product.jpeg')
product.save!

# ゲストユーザーが予め注文しておく（１件）
order = guest_user.orders.create!(sender_name: "ゲストユーザー",
                          message: "ゲストユーザーです")

order.order_items.create!(product_id: product.id,
                            price: product.price,
                          quantity: 4)

# user１が購入したギフトを予めゲストユーザーが受け取っておく（1件）
order = user.orders.create!(sender_name: "けんじろう",
                          message: "よろしくお願いします。")

3.times do |i|
  order.order_items.create!(product_id: i + 1,
  price: Product.find(i + 1).price,
  quantity: rand(1..5))
end
guest_user.receive_giftcard?(order)

# ゲストストアの商品を含む注文を複数件作成（購入者は問わない） => 注文のギフト用 日付は変える
60.times do
  guest_order = Order.create!(user_id: rand(1..2),
  sender_name: "ゲスト用注文",
  message: "ゲスト用注文です",
  created_at: "2021-04-01 01:58:35",
  updated_at: Time.zone.now - (60 * 60 * 24) * rand(0..50),
  received: true)

  guest_store.products.each do |guest_product|
    guest_order.order_items.create!(product_id: guest_product.id,
    price: guest_product.price,
    quantity: rand(1..10))
  end
end

# 注文の日付適当に分ける(現在より50日範囲のランダムで良いか?)

# ユーザー作成 + 4人
name_list = %w[aki 松崎 まるぼう ゆき]
(3..6).each do |n|
  user = User.create!(
    username: name_list[n - 3],
    email: "test_#{n}@test.com",
    password: 'foobar',
    confirmed_at: Time.zone.now
  )
  user.create_profile(name: user.username)
  user.profile.image.attach(io: File.open("./app/assets/images/user_#{n}.jpeg"), filename: 'cake.jpg')
end

# レビュー投稿（5商品以上必要）
TITILES = %w[なかなか おいしい 悪くない これこれ アリですね おすすめです]
BODIES = ["おいしすぎて、ペロッと食べてしまいました!",
          "なかなか食べたことのない美味しさです。 娘は苦手の様でした。",
          "ボリュームもあって、喜ばれました！",
          "しっとりとした食感がよかった。",
          "昔ながらのやさしい味が良いです。たくさん食べれて大満足です。",
          "しっかりとした箱入り。",
          "喜んでもらえたようです。",
          "相手の時間を気にせず送れるのはやっぱりここだけ。",
          "心のこもった美味しいお菓子をご馳走さまでした。",
          "届いたときには小さく感じましたが、食べてみるとものすごい食べ応え！",
          "毎年、年何回かは頂いております。 使っている材料、味、丁寧な作り、いずれをとっても気に入っております。",
          "甘さがしつこくなくて自分好みでした、とってもおいしかったです！"]

# レビューの投稿
# store_1,2 4~9でおkの商品から適当に6商品選ぶ > その商品に対して全員がコメント残す
(4..9).each do |product_id|
  [1, 2, 4, 5, 6, 7].each do |user_id|
    Review.create!(user_id: user_id,
    title: TITILES.sample,
                         body: BODIES.sample,
                         stars: rand(2..5),
                         product_id: product_id,
                         created_at: "2021-04-01 01:58:35",
    updated_at: Time.zone.now - (60 * 60 * 24) * rand(0..50))
  end
end

# 5.times do |_i|
#   title = Faker::Lorem.sentence
#   body = Faker::Lorem.sentence
#   user.reviews.create!(title: title,
#                        body: body,
#                        stars: rand(1..5),
#                        product_id: 1)
# end

# 10.times do |_i|
#   title = Faker::Lorem.sentence
#   body = Faker::Lorem.sentence
#   user.reviews.create!(title: title,
#                        body: body,
#                        stars: rand(1..5),
#                        product_id: 2)
# end
