module Billable
  def is_billable
    has_one :account, :as=> :billable, :dependent=>:destroy
    include InstanceMethods
  end
  module InstanceMethods
    def billable?
      true
    end
  end
end
ActiveRecord::Base.extend Billable