module Filters
  class FilterSet
    include Enumerable

    attr_reader :name, :selection_policy, :selected_values
    private :selection_policy, :selected_values

    def initialize(name, selected_value, selection_policy)
      @name = name
      @selection_policy = selection_policy
      @selected_values = selection_policy.selected_values_from(selected_value)
      @filters = []
    end

    def add_filter(name, value)
      @filters << Filter.new(self, name, value, selected_values.include?(value))
    end

    def each(&block)
      @filters.each(&block)
    end

    def selected_filters
      select(&:selected?)
    end

    def params_for_filter(filter)
      new_values = values_after_toggle_for(filter)
      new_values.empty? ? "" : "#{name}:#{new_values.map.join(",")}"
    end

    private
    def base_for_new_values
      selection_policy.base_for_new_values(selected_values)
    end

    def values_after_toggle_for(filter)
      filter.selected? ? base_for_new_values - [filter.value] : base_for_new_values + [filter.value]
    end

    class Filter
      attr_reader :name, :value
      def initialize(filter_set, name, value, selected)
        @filter_set, @name, @value, @selected = filter_set, name, value, selected
      end

      def value_after_toggle
        @filter_set.params_for_filter(self)
      end

      def selected?
        @selected
      end
    end
  end
end
