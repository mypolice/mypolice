class Address < ActiveRecord::Base
  validates :address_line1, :presence=>true
  validates :city, :presence=>true
  validates :postcode, :presence=>true, :format=>{:with=>/^[A-Z]{1,2}[0-9R][0-9A-Z]? [0-9][ABD-HJLNP-UW-Z]{2}$/}
  validates :country, :presence=>true
  def before_validation
    self.postcode.upcase!
  end
end
