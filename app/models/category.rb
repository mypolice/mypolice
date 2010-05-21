class Category < ActiveRecord::Base
  validates :name, :presence=>true, :length=>{:minimum=>1, :maximum=>50}
  has_many :post,:dependent=>:destroy
end

