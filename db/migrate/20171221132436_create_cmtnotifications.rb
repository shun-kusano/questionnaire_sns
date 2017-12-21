class CreateCmtnotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :cmtnotifications do |t|
      t.boolean :read, default: false
      t.references :user, foreign_key: true
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end
