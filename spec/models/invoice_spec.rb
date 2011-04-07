require 'spec_helper'

describe Invoice do
  it { should belong_to :billing_activity }
  it { should have_many :invoice_line_items }
  
end