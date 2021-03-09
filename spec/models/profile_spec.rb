require 'rails_helper'

RSpec.describe Profile, type: :model do
  profile = FactoryBot.create(:profile)
  it 'profileインスタンスが有効' do
    expect(profile).to be_valid
  end
end
