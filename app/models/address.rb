class Address < ActiveRecord::Base
=begin
  validates :address_line1, :presence=>true
  validates :city, :presence=>true
  validates :postcode, :presence=>true, :format=>{:with=>/^[A-Z]{1,2}[0-9R][0-9A-Z]? [0-9][ABD-HJLNP-UW-Z]{2}$/}
  validates :country, :presence=>true
  before_validation :ensure_postcode_is_uppercase
  
  protected
  def ensure_postcode_is_uppercase
    self.postcode.upcase!
  end
=end
end
