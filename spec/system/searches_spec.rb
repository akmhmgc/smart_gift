require 'rails_helper'

RSpec.describe 'Searches', type: :system do
  let(:store_a) { FactoryBot.create(:store, storename: 'foo_store') }
  let(:store_b) { FactoryBot.create(:store, storename: 'bar_store') }
  let(:store_b) { FactoryBot.create(:store) }
  let(:category_a) { FactoryBot.create(:category, name: 'ケーキ') }
  let(:category_b) { FactoryBot.create(:category, name: 'プリン ') }
  let!(:search_a) { create(:search_a, store_id: store_a.id, category_id: category_a.id) }
  let!(:search_b) { create(:search_b, store_id: store_b.id, category_id: category_b.id) }

  before do
    visit products_path
  end

  describe '検索機能' do
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
      select '¥100', from: 'q[price_gteq]'
      select '¥1000', from: 'q[price_lteq]'
      click_button '検索'
      expect(page).not_to have_content 'piyo'
      expect(page).to have_content 'hoge'
    end
  end

  describe "並び替え", js: true do
    it '価格の安い順番' do
      select '価格の安い順', from: 'q[sorts]'
      product = all('.product')
      expect(product[0]).to have_content "hoge"
      expect(product[1]).to have_content "piyo"
    end

    it '価格の高い順番' do
      select '価格の高い順', from: 'q[sorts]'
      product = all('.product')
      expect(product[0]).to have_content "piyo"
      expect(product[1]).to have_content "hoge"
    end

    describe "レビュー関連" do
      before do
        create_list(:review, 5, product_id: search_a.id, stars: 5)
        create_list(:review, 2, product_id: search_b.id, stars: 2)
      end
      it 'レビューの多い潤' do
        select 'レビューの多い順', from: 'q[sorts]'
        product = all('.product')
        expect(product[0]).to have_content "hoge"
        expect(product[1]).to have_content "piyo"
      end

      it '星の多い順番' do
        select '評価の高い順', from: 'q[sorts]'
        product = all('.product')
        expect(product[0]).to have_content "hoge"
        expect(product[1]).to have_content "piyo"
      end
    end
  end
end
