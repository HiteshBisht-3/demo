class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :caption 
      t.boolean :active
      t.references :user
      t.timestamps
    end
  end
end
