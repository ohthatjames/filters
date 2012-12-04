module Filters
  class MultiSelectPolicy
    def multi_select_allowed?
      true
    end

    def selected_values_from(value)
      value.split(',')
    end
  end
end
