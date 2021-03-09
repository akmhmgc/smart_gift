require 'rails_helper'

RSpec.describe Store, type: :model do
  store = FactoryBot.build(:store)
  it 'storeインスタンスが有効' do
    expect(store).to be_valid
  end
end
