class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :materials
      t.text :instructions
      t.integer :user_id
    end
  end
end
