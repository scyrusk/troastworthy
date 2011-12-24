class Troast < ActiveRecord::Base
  belongs_to :user

  has_attached_file :image,
    :styles => { :thumb => "60x60" },
    :storage => :s3,
    :bucket => 'tw_bucket',
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    }

  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/bmp', 'image/gif']

  def destroyAll
    Troast.all.each do |t|
      t.destroy
    end
  end

  #heroku compatibility randomness
  def self.dummyMethod
    return 1
  end
end
