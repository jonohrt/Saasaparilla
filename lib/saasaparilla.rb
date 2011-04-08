module Saasaparilla
  require 'saasaparilla/engine' if defined?(Rails)
end

require 'extensions/billable'
require 'country_select/lib/country_select'
require 'extensions/active_record/statuses'
require 'extensions/active_record/nested_attributes'