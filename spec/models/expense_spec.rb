require 'rails_helper'

RSpec.describe Expense, type: :model do
  it 'validates presence of name' do
    expense = Expense.new(amount: 100)
    expect(expense).not_to be_valid
    expect(expense.errors[:name]).to include("can't be blank")
  end

  it 'validates presence of amount' do
    expense = Expense.new(name: 'Sample Expense')
    expect(expense).not_to be_valid
    expect(expense.errors[:amount]).to include("can't be blank")
  end

  describe 'associations' do
    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has and belongs to many categories' do
      association = described_class.reflect_on_association(:categories)
      expect(association.macro).to eq(:has_and_belongs_to_many)
    end
  end
end
