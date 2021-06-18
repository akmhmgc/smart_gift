desc "This task is called by the Heroku scheduler add-on"
task :test_scheduler => :environment do
  puts "scheduler test"
  puts "it works."
  Rails.logger.info("ログのテスト")
end

desc "ゲストデータのリセットを行う"
task :reset_guestdata => :environment do
  guest_user = User.find_by(email:'guest_user@example.com')
  guest_user.reviews.destroy_all

  guest_store = Store.find_by(email: 'guest_store@example.com')
  item_1 = guest_store.products.order(:created_at).first
  item_2 = guest_store.products.order(:created_at).second
  item_1.image.attach(io: File.open('./app/assets/images/chocolate_1-min.jpeg'), filename: 'store_2_product.jpeg')
  item_1.update(name: "おいしいチョコバー",
    price: 450,
    category_id: Category.find_by(name: "チョコレート").id,
    description: 'おいしいチョコバーです。')

   sleep 1
   item_2.image.attach(io: File.open('./app/assets/images/chocolate_2-min.jpeg'), filename: 'store_2_product.jpeg')
   item_2.update(name: "いちごのチョコレート",
    price: 560,
    category_id: Category.find_by(name: "チョコレート").id,
    description: 'いちごのチョコレートです。')
   puts "ended!"
end