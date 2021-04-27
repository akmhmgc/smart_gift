namespace :guest_user_reset do
    desc "ゲストユーザーの投稿をリセットする"
    task profile_1_name_change: :environment do
    Profile.first.update!(name:"テスト商店")
      end
end