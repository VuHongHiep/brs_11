class Book < ActiveRecord::Base
  belongs_to :category

  has_many :read_statuses, dependent: :destroy
  has_many :pictures, dependent: :destroy

  accepts_nested_attributes_for :pictures

  has_attached_file :document, styles: {thumbnail: ["180x180#", :png]}
  validates_attachment :document, content_type: {content_type: "application/pdf"}

  scope :at_category, -> category {where(category: category) if category}
  scope :title_like, -> title {where("title like ?", "%#{title}%")}
  scope :author_like, -> author {where("author like ?", "%#{author}%")}
end
