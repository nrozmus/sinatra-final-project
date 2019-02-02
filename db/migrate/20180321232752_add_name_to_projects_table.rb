class AddNameToProjectsTable < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :name, :string
  end
