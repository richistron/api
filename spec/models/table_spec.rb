require 'rails_helper'

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


    it 'should not duplicates' do
      table = create :table
      expect(table.save!).to eq(true)
      expect { create :table }.to raise_error(ActiveRecord::RecordInvalid)
    end

  end

end

