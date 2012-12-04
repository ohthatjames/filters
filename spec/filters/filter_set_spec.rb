require 'spec_helper'

describe Filters::FilterSet do
  describe "with no multiselect allowed" do
    def size_filter_set(selected="")
      filter_set = Filters::FilterSet.new("size", selected, false)
      filter_set.add_filter("small", "s")
      filter_set.add_filter("medium", "m")
      filter_set.add_filter("large", "l")
      filter_set
    end

    it "has all filters not selected by default" do
      size_filter_set.selected_filters.should == []
    end

    it "returns the selected filter when one is selected" do
      size_filter_set("m").selected_filters.map(&:name).should == ["medium"]
    end

    it "returns a URL for selecting each filter" do
      size_filter_set.map(&:value_after_toggle).should == ["size:s", "size:m", "size:l"]
    end

    it "returns the param to turn a filter off if selected" do
      size_filter_set("m").map(&:value_after_toggle).should == ["size:s", "", "size:l"]
    end

    it "doesn't allow multi-selection" do
      size_filter_set("m,l").selected_filters.map(&:name).should == []
    end
  end

  describe "with multiselect allowed" do
    def multi_filter_set(selected="")
      filter_set = Filters::FilterSet.new("colour", selected, true)
      filter_set.add_filter("red", "red")
      filter_set.add_filter("green", "green")
      filter_set.add_filter("white", "white")
      filter_set
    end

    it "allows multiple filters to be selected at once, separated by commas" do
      multi_filter_set("red,green").selected_filters.map(&:name).should == ["red", "green"]
    end

    it "returns a URL param for selecting each filter" do
      multi_filter_set("").map(&:value_after_toggle).should == ["colour:red", "colour:green", "colour:white"]
    end

    it "appends extra parameters if a parameter is already selected" do
      multi_filter_set("red").map(&:value_after_toggle).should == ["", "colour:red,green", "colour:red,white"]
    end
  end
end
