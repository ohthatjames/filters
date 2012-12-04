module Filters
  class Filter
    attr_reader :name, :value
    def initialize(filter_set, name, value, selected)
      @filter_set, @name, @value, @selected = filter_set, name, value, selected
    end

    def value_after_toggle
      @filter_set.value_after_toggle_for_filter(self)
    end

    def selected?
      @selected
    end
  end
end
