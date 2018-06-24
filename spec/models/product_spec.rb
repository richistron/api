require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'smoke tests' do
    it 'valid' do
      product = build :product, tenant: create(:tenant)
      expect(product.valid?).to be(true)
    end

    it 'invalid' do
      product = build :product, tenant: create(:tenant)
      product.price = nil
      expect(product.valid?).to be(false)
    end

    it 'numeric price' do
      product = build :product, tenant: create(:tenant)
      product.price = 'A'
      expect(product.valid?).to be(false)
    end
  end
end
