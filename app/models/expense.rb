class Expense < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  has_and_belongs_to_many :categories, join_table: 'expenses_categories', dependent: :destroy
  validates :name, presence: true
  validates :amount, presence: true
end
