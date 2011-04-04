module Billable
  def is_billable
    #has_many :reviews, :as=>:reviewable, :dependent=>:destroy
    include InstanceMethods
  end
  module InstanceMethods
    def billable?
      true
    end
  end
end
ActiveRecord::Base.extend Billable