class ActiveRecord::Base 
  module ClassMethods
    def accepts_nested_attributes_for(*attr_names)
      options = { :allow_destroy => false, :update_only => false }
      options.update(attr_names.extract_options!)
      options.assert_valid_keys(:allow_destroy, :reject_if, :limit, :update_only)
      options[:reject_if] = REJECT_ALL_BLANK_PROC if options[:reject_if] == :all_blank
      
      attr_names.each do |association_name|
        if reflection = reflect_on_association(association_name)
          #Removed autosave association
          #reflection.options[:autosave] = true
          add_autosave_association_callbacks(reflection)
          nested_attributes_options[association_name.to_sym] = options
          type = (reflection.collection? ? :collection : :one_to_one)

          # def pirate_attributes=(attributes)
          #   assign_nested_attributes_for_one_to_one_association(:pirate, attributes)
          # end
          class_eval <<-eoruby, __FILE__, __LINE__ + 1
            if method_defined?(:#{association_name}_attributes=)
              remove_method(:#{association_name}_attributes=)
            end
            def #{association_name}_attributes=(attributes)
              assign_nested_attributes_for_#{type}_association(:#{association_name}, attributes)
            end
          eoruby
        else
          raise ArgumentError, "No association found for name `#{association_name}'. Has it been defined yet?"
        end
      end
    end

  end
end
ActiveRecord::Base.extend ActiveRecord::Base::ClassMethods