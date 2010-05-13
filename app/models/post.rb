class Post < ActiveRecord::Base
  validates_presence_of :body, :title
  has_many :comments, :dependent => :destroy
  has_many :responses, :dependent => :destroy
  belongs_to :user
  belongs_to :category
  scope :approved, where(:approved=>true)
  scope :unapproved, where(:approved=>false)

  acts_as_taggable
end
