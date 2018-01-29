class CreateImports < ActiveRecord::Migration[5.1]
  def change
    create_table :imports do |t|
      t.integer :shop_id
      t.integer :count_created
      t.integer :count_updated

      t.timestamps
    end
  end
end
