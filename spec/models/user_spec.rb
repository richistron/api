require 'rails_helper'

RSpec.describe User, type: :model do

  it 'should create a new user' do
    tenant = create :tenant
    user = create :user, tenant: tenant
    expect(user.valid?).to eq(true)
  end

  it 'should not create a new user' do
    user = build :user
    expect(user.valid?).to eq(false)
  end
end

