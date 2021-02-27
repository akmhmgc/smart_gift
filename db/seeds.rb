store = Store.create!(storename: '山田商店',
                      email: 'test@test.com',
                      password: 'foobar')
# active
store.image.attach(io: File.open('./app/assets/images/minion.jpg'), filename: 'minion.jpg')

# 商品の登録
10.times do
  product = store.products.create!(name: 'テストケーキ',
                                   price: 500)
  product.image.attach(io: File.open('./app/assets/images/cake.jpg'), filename: 'cake.jpg')
end
