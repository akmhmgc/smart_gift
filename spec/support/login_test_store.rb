module LoginTestStore
  def login_test_store(which_store)
    visit new_store_session_path
    sleep 2
    fill_in 'メールアドレス', with: which_store.email
    fill_in 'パスワード', with: which_store.password
    click_on 'ログインする'
  end
end
