class Post < ActiveRecord::Base
  validates_presence_of :body, :title
  has_many :comments, :dependent => :destroy
  has_many :responses, :dependent => :destroy
  belongs_to :user
  named_scope :approved, :conditions => ['approved = ?', true]
  named_scope :unapproved, :conditions => ['approved =?', false]

  acts_as_taggable
end
