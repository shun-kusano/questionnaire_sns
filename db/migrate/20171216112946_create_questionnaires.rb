class CreateQuestionnaires < ActiveRecord::Migration[5.1]
  def change
    create_table :questionnaires do |t|
      t.text :body
      t.string :qimage
      t.datetime :date_by

      t.timestamps
    end
  end
end
