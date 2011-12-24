class User < ActiveRecord::Base
  has_many :troasts
  serialize :about_troasts, Array

  has_attached_file :photo,
    :styles => {
      :thumb => "60x60",
      :profile => "130x130",
      :gray => "130x130" },
    :convert_options => { :gray => '-colorspace Gray' },
    :storage => :s3,
    :bucket => 'tw_bucket',
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    }

  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/bmp', 'image/gif']

  def deleteAboutTroast(troast)
    about_troasts.delete(troast)
    save
  end

  def self.clearAboutTroasts
    User.all.each do |u|
      u.about_troasts.clear
      u.save
    end
  end
  
  def self.search(varstr)
    @user = User.find_by_uid(varstr)
  end

  # Decrypts a block of data (encrypted_data) given an encryption key
  # and an initialization vector (iv).  Keys, iv's, and the data 
  # returned are all binary strings.  Cipher_type should be
  # "AES-256-CBC", "AES-256-ECB", or any of the cipher types
  # supported by OpenSSL.  Pass nil for the iv if the encryption type
  # doesn't use iv's (like ECB).
  #:return: => String
  #:arg: encrypted_data => String 
  #:arg: key => String
  #:arg: iv => String
  #:arg: cipher_type => String
  def self.decrypt(encrypted_data, key, iv, cipher_type="AES-256-ECB")
    aes = OpenSSL::Cipher::Cipher.new(cipher_type)
    aes.decrypt
    aes.key = key
    aes.iv = iv if iv != nil
    aes.update(encrypted_data) + aes.final  
  end
  
  # Encrypts a block of data given an encryption key and an 
  # initialization vector (iv).  Keys, iv's, and the data returned 
  # are all binary strings.  Cipher_type should be "AES-256-CBC",
  # "AES-256-ECB", or any of the cipher types supported by OpenSSL.  
  # Pass nil for the iv if the encryption type doesn't use iv's (like
  # ECB).
  #:return: => String
  #:arg: data => String 
  #:arg: key => String
  #:arg: iv => String
  #:arg: cipher_type => String  
  def self.encrypt(data, key, iv, cipher_type="AES-256-ECB")
    aes = OpenSSL::Cipher::Cipher.new(cipher_type)
    aes.encrypt
    aes.key = key
    aes.iv = iv if iv != nil
    aes.update(data) + aes.final      
  end


  def self.sub(data, key)
    alphanums = [*('a'..'z'),*('A'..'Z'),*('0'..'9')]*2 #array of all alphabet and numbers produced by SHA2
    data.tr([*('a'..'z'),*('A'..'Z'),*('0'..'9')].join, alphanums[key..key+62].join)
  end

  def self.unsub(data,key)
    alphanums = [*('a'..'z'),*('A'..'Z'),*('0'..'9')]*2 #array of all alphabet and numbers produced by SHA2
    data.tr(alphanums[key..key+62].join,[*('a'..'z'),*('A'..'Z'),*('0'..'9')].join)
  end
end
