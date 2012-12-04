module Filters
  class MultiSelectPolicy
    def multi_select_allowed?
      true
    end

    def selected_values_from(value)
      value.split(',')
    end

    def base_for_new_values(values)
      values
    end
  end
end
