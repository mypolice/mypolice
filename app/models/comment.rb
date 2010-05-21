class Comment < ActiveRecord::Base
  validates :body, :presence=>true
  belongs_to :post
  belongs_to :user
  scope :approved, where(:approved => true)
  scope :unapproved, where(:approved => false)
end
