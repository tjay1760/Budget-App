class Category < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :expenses, join_table: 'expenses_categories', dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :icon, presence: true

  def total_amount
    expenses.sum(:amount)
  end
end
