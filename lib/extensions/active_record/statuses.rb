class ActiveRecord::Base
  def self.has_statuses(*status_names) 
    validates :status, :presence => true, :inclusion => { :in => status_names }
    # Status Finders 
    status_names.each do |status_name|
      scope "all_#{status_name}", where(:status => status_name)
    end
    # Status Accessors 
    status_names.each do |status_name|
      define_method "#{status_name}?" do
        status == status_name
      end
    end 
    
  end
end