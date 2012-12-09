module Filters
  class MultiSelectPolicy
    def selected_values_from(value)
      value.split(',')
    end

    def base_for_new_values(values)
      values
    end
  end
end
