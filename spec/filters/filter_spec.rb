require 'spec_helper'

describe Filters::Filter do
  describe "with no multiselect allowed" do
    def size_filter(selected="")
      filter = Filters::Filter.new("size", selected, Filters::SingleSelectPolicy.new)
      filter.add_option("small", "s")
      filter.add_option("medium", "m")
      filter.add_option("large", "l")
      filter
    end

    it "has all filters not selected by default" do
      size_filter.selected_options.should == []
    end

    it "returns the selected filter when one is selected" do
      size_filter("m").selected_options.map(&:name).should == ["medium"]
    end

    it "returns a URL for selecting each filter" do
      size_filter.map(&:param_after_toggle).should == ["size:s", "size:m", "size:l"]
    end

    it "returns the param to turn a filter off if selected" do
      size_filter("m").map(&:param_after_toggle).should == ["size:s", "", "size:l"]
    end

    it "doesn't allow multi-selection" do
      size_filter("m,l").selected_options.map(&:name).should == []
    end
  end

  describe "with multiselect allowed" do
    def multi_filter(selected="")
      filter = Filters::Filter.new("colour", selected, Filters::MultiSelectPolicy.new)
      filter.add_option("red", "red")
      filter.add_option("green", "green")
      filter.add_option("white", "white")
      filter
    end

    it "allows multiple filters to be selected at once, separated by commas" do
      multi_filter("red,green").selected_options.map(&:name).should == ["red", "green"]
    end
    
    it "has a default current param of the empty string" do
      multi_filter.current_param.should == ""
    end
    
    it "has a current param of all its selections" do
      multi_filter("red,green").current_param.should == "colour:red,green"
    end

    it "returns a URL param for selecting each filter" do
      multi_filter("").map(&:param_after_toggle).should == ["colour:red", "colour:green", "colour:white"]
    end

    it "appends extra parameters if a parameter is already selected" do
      multi_filter("red").map(&:param_after_toggle).should == ["", "colour:red,green", "colour:red,white"]
    end
  end
end
