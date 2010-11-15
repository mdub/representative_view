require 'spec_helper'

describe "fixtures" do
  
    it "contains books" do
      Books.all.should be_kind_of(Array)
    end
    
end
