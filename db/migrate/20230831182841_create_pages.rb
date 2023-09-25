class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.string :name
      t.string :title
      t.text :content
      t.integer :parent_id
      t.string "ancestry", collation: 'C', null: false
      t.index "ancestry"
      t.timestamps
    end
  end
end
