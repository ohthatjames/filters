module Filters
  class SingleSelectPolicy
    def selected_values_from(value)
      value.empty? ? [] : [value]
    end

    def base_for_new_values(values)
      []
    end
  end
end
