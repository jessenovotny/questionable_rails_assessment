class CreateUpvotes < ActiveRecord::Migration[5.0]
  def change
    create_table :upvotes do |t|
      t.integer :voter_id
      t.integer :answer_id
    end
  end
end
