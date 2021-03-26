require 'rails_helper'

RSpec.describe 'Reviews', type: :system do
  let(:current_user) { FactoryBot.create(:user, email: 'user_test@test.com') }
  let(:current_product) { FactoryBot.create(:product) }
end
