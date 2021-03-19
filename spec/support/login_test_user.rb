module LoginTestUser
  def login_test_user(which_user)
    visit root_path
    click_link 'ログイン', match: :first
    sleep 2
    fill_in 'メールアドレス', with: which_user.email
    fill_in 'パスワード', with: which_user.password
    click_on 'ログインする'
  end
end
