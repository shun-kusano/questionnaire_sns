class CreateAnswerbs < ActiveRecord::Migration[5.1]
  def change
    create_table :answerbs do |t|
      t.references :questionnaire, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :answerbs, [:questionnaire_id, :user_id], unique: true
  end
end
