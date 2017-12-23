class CreateFavnotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :favnotifications do |t|
      t.boolean :read, default: false
      t.references :user, foreign_key: true
      t.references :questionnaire, foreign_key: true

      t.timestamps
    end
  end
end
