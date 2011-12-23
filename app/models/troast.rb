class Troast < ActiveRecord::Base
  belongs_to :user

  has_attached_file :image,
    :styles => { :thumb => "60x60" }

  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/bmp', 'image/gif']

  def destroyAll
    Troast.all.each do |t|
      t.destroy
    end
  end
end
