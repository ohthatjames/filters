module Filters
  class FilterOption
    attr_reader :name, :value
    def initialize(filter, name, value, selected)
      @filter, @name, @value, @selected = filter, name, value, selected
    end

    def value_after_toggle
      @filter.value_after_toggle_for_filter(self)
    end

    def selected?
      @selected
    end
  end
end
