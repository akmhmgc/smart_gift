Faker::Config.locale = :ja

store = Store.create!(storename: '山田商店',
                      email: 'test@test.com',
                      password: 'foobar',
                      confirmed_at: Time.zone.now)

store2 = Store.create!(storename: '田中商店',
                      email: 'test2@test.com',
                      password: 'foobar',
                      confirmed_at: Time.zone.now)
# active
store.image.attach(io: File.open('./app/assets/images/minion.jpg'), filename: 'minion.jpg')

# カテゴリの登録
sweets = Category.create!(name: 'お菓子')
cake = sweets.children.create!({ name: 'ケーキ' })
pudding = sweets.children.create!({ name: 'プリン' })

# 商品の登録
20.times do |i|
  product = store.products.create!(name: "テストケーキ_#{i}",
                                   price: 100 * (i + 1),
                                   category_id: cake.id,
                                   description: '最高のケーキです',
                                   stock: i)
  product.image.attach(io: File.open('./app/assets/images/cake.jpg'), filename: 'cake.jpg')
end

20.times do |i|
  product = store.products.create!(name: "テストプリン_#{i}",
                                   price: 300 * (i + 1),
                                   category_id: pudding.id,
                                   description: '最高のプリンです',
                                   stock: i)
  product.image.attach(io: File.open('./app/assets/images/pudding.jpg'), filename: 'cake.jpg')
end

# 非公開商品の作成
5.times do |i|
  product = store.products.create!(name: "非公開プリン_#{i}",
                                   price: 300 * (i + 1),
                                   category_id: pudding.id,
                                   description: '非公開のプリンです',
                                   stock: i,
                                   publish: false)
  product.image.attach(io: File.open('./app/assets/images/pudding.jpg'), filename: 'cake.jpg')
end

user = User.create!(
  username: 'テスト太郎',
  email: 'test@test.com',
  password: 'foobar',
  confirmed_at: Time.zone.now
)

user.create_profile(name: user.username)
user.profile.image.attach(io: File.open('./app/assets/images/pudding.jpg'), filename: 'cake.jpg')

user2 = User.create!(
  username: 'テスト君',
  email: 'test2@test.com',
  password: 'foobar',
  confirmed_at: Time.zone.now
)

user2.create_profile(name: user.username)
user2.profile.image.attach(io: File.open('./app/assets/images/pudding.jpg'), filename: 'cake.jpg')

# レビューの投稿
20.times do |_i|
  title = Faker::Lorem.sentence
  body = Faker::Lorem.sentence
  user.reviews.create!(title: title,
                       body: body,
                       product_id: 1)
end

# いいね
user.like(Product.first)
Product.first.create_notification_like!(user)
