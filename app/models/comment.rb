class Comment < ActiveRecord::Base
  validates_presence_of :body
  belongs_to :post
  belongs_to :user
  named_scope :approved, :conditions => ['approved = ?', true]
  named_scope :unapproved, :conditions => ['approved =?', false]
end
