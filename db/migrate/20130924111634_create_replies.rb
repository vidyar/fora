class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :body,      null: false
      t.references :user,  index: true
      t.references :topic, index: true
      t.integer    :likes_count,   default: 0

      t.timestamps
    end
  end
end
