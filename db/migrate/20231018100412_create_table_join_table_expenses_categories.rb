class CreateTableJoinTableExpensesCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses_categories do |t|
      t.references :expense, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
  end
end
end