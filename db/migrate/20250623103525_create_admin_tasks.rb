class CreateAdminTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :admin_tasks do |t|
      t.string :title
      t.text :descrption
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
