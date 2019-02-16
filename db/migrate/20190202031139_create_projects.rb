class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :technical_analysis
      t.integer :user_id
    end
  end
end
