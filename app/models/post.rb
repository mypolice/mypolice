class Post < ActiveRecord::Base
  validates_presence_of :body, :title
  has_many :comments, :dependent => :destroy
  has_many :responses, :dependent => :destroy
  belongs_to :user
  belongs_to :category
  scope :approved, where(:approved=>true)
  scope :unapproved, where(:approved=>false)
  scope :anonymous, where(:use_id=>nil) 
  acts_as_taggable
  cattr_reader :per_page
  @@per_page =10

  def self.search(search, page)
    paginate :per_page => 10, :page => page,
             :conditions => ['body like ?', "%#{search}%"], :order => 'created_at DESC'
  end
  
  
end
