class AddEditableToTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :editable, :boolean
  end
end
