Faker::Config.locale = :ja

store = Store.create!(storename: '山田商店',
                      email: 'test@test.com',
                      password: 'foobar')
# active
store.image.attach(io: File.open('./app/assets/images/minion.jpg'), filename: 'minion.jpg')

# カテゴリの登録
sweets = Category.create!(name: 'お菓子')
cake = sweets.children.create!({ name: 'ケーキ' })
pudding = sweets.children.create!({ name: 'プリン' })

# 商品の登録(bulk insertでリファクタリング可能)
20.times do |i|
  product = store.products.create!(name: 'テストケーキ',
                                   price: 100 * i,
                                   category_id: cake.id)
  product.image.attach(io: File.open('./app/assets/images/cake.jpg'), filename: 'cake.jpg')
end

20.times do |i|
  product = store.products.create!(name: 'テストプリン',
                                   price: 300 * i,
                                   category_id: pudding.id)
  product.image.attach(io: File.open('./app/assets/images/pudding.jpg'), filename: 'cake.jpg')
end

user = User.create!(
  email: 'test@test.com',
  password: 'foobar',
  confirmed_at: Time.zone.now
)


# レビューの投稿
20.times do |_i|
  title = Faker::Lorem.sentence
  body = Faker::Lorem.sentence
  user.reviews.create!(title: title,
                       body: body,
                       product_id: 1)
end
