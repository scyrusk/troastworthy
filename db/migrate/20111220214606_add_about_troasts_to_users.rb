class AddAboutTroastsToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :about_troasts
    add_column :users, :about_troasts, :text

    User.all.each {|u| u.update_attributes!(:about_troasts => [])}
  end
end
