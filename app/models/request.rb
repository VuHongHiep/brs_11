class Request < ActiveRecord::Base
  belongs_to :user

  has_many :pictures, dependent: :destroy

  accepts_nested_attributes_for :pictures

  validates :title, presence: true, length: {maximum: 100}
  validates :content, presence: true, length: {maximum: 300}

  def pending?
    solve == "pending"
  end
end
