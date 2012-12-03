require 'spec_helper'

describe Filters::FilterSet do
  describe "with no multiselect allowed" do
    it "has all filters not selected by default" do
      filter_set = Filters::FilterSet.new("size")
      filter_set.add_filter("small", "s")
      filter_set.add_filter("medium", "m")
      filter_set.add_filter("large", "l")
      filter_set.selected_filters.should == []
    end

    it "returns the selected filter when one is selected" do
      filter_set = Filters::FilterSet.new("size", "m")
      filter_set.add_filter("small", "s")
      filter_set.add_filter("medium", "m")
      filter_set.add_filter("large", "l")
      filter_set.selected_filters.map(&:name).should == ["medium"]
    end

    it "returns a URL for selecting each filter" do
      filter_set = Filters::FilterSet.new("size")
      filter_set.add_filter("small", "s")
      filter_set.add_filter("medium", "m")
      filter_set.add_filter("large", "l")
      filter_set.map(&:param_to_select).should == ["size:s", "size:m", "size:l"]
    end

    it "returns the param to turn a filter off if selected" do
      filter_set = Filters::FilterSet.new("size", "m")
      filter_set.add_filter("small", "s")
      filter_set.add_filter("medium", "m")
      filter_set.add_filter("large", "l")
      filter_set.map(&:param_to_select).should == ["size:s", "", "size:l"]
    end
  end
end
