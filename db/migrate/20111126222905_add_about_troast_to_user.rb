class AddAboutTroastToUser < ActiveRecord::Migration
  def change
    add_column :users, :about_troasts, :string

    User.all.each {|u| u.update_attributes!(:about_troasts => [])}
  end
end
