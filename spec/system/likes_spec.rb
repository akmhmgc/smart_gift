require 'rails_helper'

RSpec.describe 'Likes', type: :system do
  let(:current_user) { FactoryBot.create(:user) }
  let!(:current_profile) { FactoryBot.create(:profile, name: current_user.username, user_id: current_user.id) }
  let!(:current_product) { FactoryBot.create(:product) }

  # let(:current_like) { FactoryBot.create(:comment, review_id: current_rev.id, user_id: current_user.id) }

  describe 'ユーザーがログインしているとき', js: true do
    before do
      login_test_user(login_user)
      visit products_path
    end

    context 'いいねができること' do
      let(:login_user) { current_user }

      it 'いいねをしたあとに解除もできること' do
        find('#like_form-1').click
        expect(page).to have_selector 'svg', id: 'unlike_heart'
        expect(page).to have_selector 'span', text: '1'
        find('#like_form-1').click
        expect(page).to have_selector 'svg', id: 'like_heart'
      end

    end
  end

  describe 'ユーザーがログインしていないとき' do
    before do
      visit products_path
    end

    it 'いいねができないこと' do
      expect(page).not_to have_selector 'svg', id: 'like_heart'
    end
  end
end
