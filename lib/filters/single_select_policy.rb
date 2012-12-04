module Filters
  class SingleSelectPolicy
    def multi_select_allowed?
      false
    end

    def selected_values_from(value)
      value.empty? ? [] : [value]
    end

    def base_values(values)
      []
    end
  end
end
