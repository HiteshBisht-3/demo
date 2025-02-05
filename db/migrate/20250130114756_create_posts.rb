class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.references :user
      t.string :caption
      t.string :image

      t.timestamps
    end
  end
end
