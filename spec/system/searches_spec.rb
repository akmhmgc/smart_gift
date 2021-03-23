require 'rails_helper'

RSpec.describe 'Searches', type: :system do
  let(:store_a) { FactoryBot.create(:store, storename: 'foo_store') }
  let(:store_b) { FactoryBot.create(:store, storename: 'bar_store') }
  let(:store_b) { FactoryBot.create(:store) }
  let(:category_a) { FactoryBot.create(:category, name: 'ケーキ') }
  let(:category_b) { FactoryBot.create(:category, name: 'プリン ') }
  describe '検索機能' do
    before do
      FactoryBot.create(:search_a, store_id: store_a.id, category_id: category_a.id)
      FactoryBot.create(:search_b, store_id: store_b.id, category_id: category_b.id)
      visit products_path
    end

    it '検索したキーワード「hoge」が商品名に含まれる商品が一覧表示される' do
      fill_in 'search', with: 'piyo'
      click_button '検索'
      expect(page).not_to have_content 'hoge'
      expect(page).to have_content 'piyo'
    end

    it '検索したキーワード「foo」が店舗名に含まれる商品が一覧表示される' do
      fill_in 'search', with: 'foo'
      click_button '検索'
      expect(page).not_to have_content 'bar_store'
      expect(page).to have_content 'foo_store'
    end

    it '指定したカテゴリに属する商品が一覧表示される' do
      find("option[value=#{category_a.id}]").select_option
      click_button "検索"
      expect(page).not_to have_content "piyo"
      expect(page).to have_content "hoge"
    end

    it '指定した価格範囲に属する商品が一覧表示される' do
      fill_in 'q_price_gteq', with: "0"
      fill_in 'q_price_lteq', with: "800"
      click_button '検索'
      expect(page).not_to have_content 'piyo'
      expect(page).to have_content 'hoge'
    end

    pending '並び替え'
  end
end
