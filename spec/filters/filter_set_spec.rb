require 'spec_helper'

describe Filters::FilterSet do
  describe "with no multiselect allowed" do
    def size_filter_set(selected="")
      filter_set = Filters::FilterSet.new("size", selected)
      filter_set.add_filter("small", "s")
      filter_set.add_filter("medium", "m")
      filter_set.add_filter("large", "l")
      filter_set
    end

    let(:multi_filter_set) do
      filter_set = Filters::FilterSet.new("colour")
      filter_set.add_filter("red", "red")
      filter_set.add_filter("green", "green")
      filter_set.add_filter("white", "white")
      filter_set
    end

    it "has all filters not selected by default" do
      size_filter_set.selected_filters.should == []
    end

    it "returns the selected filter when one is selected" do
      size_filter_set("m").selected_filters.map(&:name).should == ["medium"]
    end

    it "returns a URL for selecting each filter" do
      size_filter_set.map(&:param_to_select).should == ["size:s", "size:m", "size:l"]
    end

    it "returns the param to turn a filter off if selected" do
      size_filter_set("m").map(&:param_to_select).should == ["size:s", "", "size:l"]
    end
  end
end
