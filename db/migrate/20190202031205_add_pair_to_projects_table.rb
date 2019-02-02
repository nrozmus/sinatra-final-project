class AddPairToProjectsTable < ActiveRecord::Migration
  def change
    add_column :projects, :pair, :string
  end
end
