class AddPrivateIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :pid, :string
    add_column :users, :image, :binary

    User.all.each { |u| u.update_attributes!(:pid => Digest::SHA2.hexdigest((u.name + u.year.to_s).split('').shuffle.inject{|cum,n| cum + n}))}
  end
end
