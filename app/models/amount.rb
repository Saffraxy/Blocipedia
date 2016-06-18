class Amount < ActiveRecord::Base

  def self.default(x=1500)
    x
  end

end
