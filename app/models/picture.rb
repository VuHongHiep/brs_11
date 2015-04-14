class Picture < ActiveRecord::Base
  belongs_to :book
  belongs_to :request

  mount_uploader :picture, PictureUploader
  
end
