class AddUserIdToComments < ActiveRecord::Migration[5.1]
  def change
    add_reference :comments, :questionnaire, foreign_key: true
  end
end
