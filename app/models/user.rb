class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable :confirmable and :activatable
  #acts_as_authentic 
  has_many :post, :dependent => :destroy
  has_many :comment, :dependent => :destroy
  #has_many :assignment
  #has_many :roles, :through => :assignment
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation

end
