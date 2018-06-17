require 'rails_helper'
require 'factory_bot'

RSpec.describe Table, type: :model do

  context 'smoke tests' do

    it 'should create a new Table' do
      table = create :table
      expect(table.save!).to eq(true)
    end


    it 'should not create a new Table' do
      table = create :table
      table.name = nil
      expect(table.valid?).to eq(false)
    end

  end

end

