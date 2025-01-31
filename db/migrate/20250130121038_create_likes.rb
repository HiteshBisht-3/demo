class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.belongs_to :likeable, polymorphic: true
      t.timestamps 
    end
  end
end
