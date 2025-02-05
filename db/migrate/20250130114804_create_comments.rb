class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.references :user
      t.references :post
      t.timestamps
    end
  end
end
