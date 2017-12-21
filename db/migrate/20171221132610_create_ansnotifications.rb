class CreateAnsnotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :ansnotifications do |t|
      t.boolean :answered, default: false
      t.references :user, foreign_key: true
      t.references :questionnaire, foreign_key: true

      t.timestamps
    end
  end
end
