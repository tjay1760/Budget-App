class CreateCategory < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|

      t.timestamps
    end
  end
end