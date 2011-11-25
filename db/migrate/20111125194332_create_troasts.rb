class CreateTroasts < ActiveRecord::Migration
  def change
    create_table :troasts do |t|
      t.text :body
      t.datetime :date
      t.boolean :toast
      t.boolean :anonymous

      t.timestamps
    end
  end
end
