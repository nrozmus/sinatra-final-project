class CreateSinatras < ActiveRecord::Migration
  def change
    create_table :sinatras do |t|

      t.timestamps null: false
    end
  end
end
