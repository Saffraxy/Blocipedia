class Amount < ActiveRecord::Base

  def self.default(x=1000)
    x
  end

end
