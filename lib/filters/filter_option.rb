module Filters
  class FilterOption
    attr_reader :name, :value
    def initialize(filter, name, value, selected)
      @filter, @name, @value, @selected = filter, name, value, selected
    end

    def param_after_toggle
      @filter.param_after_toggle_for(self)
    end

    def selected?
      @selected
    end
  end
end
