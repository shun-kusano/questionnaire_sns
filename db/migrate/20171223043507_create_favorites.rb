class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.references :questionnaire, foreign_key: true

      t.timestamps
    end
    add_index :favorites, [:questionnaire_id, :user_id], unique: true
  end
end
