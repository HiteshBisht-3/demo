class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.references :user
      t.references :post
      t.timestamps
      t.index [ :user_id, :post_id ], unique: true
    end
  end
end
