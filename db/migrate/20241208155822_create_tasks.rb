class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.string :category
      t.string :priority

      t.timestamps
    end
  end
end
