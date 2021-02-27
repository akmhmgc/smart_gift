store = Store.create!(storename: '山田商店',
                      email: 'test@test.com',
                      password: 'foobar')
# active
store.image.attach(io: File.open('./app/assets/images/minion.jpg'), filename: 'minion.jpg')
