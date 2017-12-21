class CreateQuestionnaires < ActiveRecord::Migration[5.1]
  def change
    create_table :questionnaires do |t|
      t.text :body
      t.string :qimage
      t.datetime :date_by
      t.text :optiona_body
      t.string :optiona_image
      t.text :optionb_body
      t.string :optionb_image
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
