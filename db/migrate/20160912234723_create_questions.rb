class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :content
      t.integer :asker_id
    end
  end
end
