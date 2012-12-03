module Filters
  class FilterSet
    include Enumerable

    attr_reader :name
    def initialize(name, multi_select_allowed, selected_value)
      @name = name
      @selected_values = multi_select_allowed ? selected_value.split(',') : [selected_value]
      @filters = []
    end

    def add_filter(name, value)
      @filters << Filter.new(self, name, value, @selected_values.include?(value))
    end

    def each(&block)
      @filters.each(&block)
    end

    def selected_filters
      select(&:selected?)
    end

    class Filter
      attr_reader :name, :value
      def initialize(filter_set, name, value, selected)
        @filter_set, @name, @value, @selected = filter_set, name, value, selected
      end

      def param_to_select
        selected? ? "" : "#{@filter_set.name}:#{@value}"
      end

      def selected?
        @selected
      end
    end
  end
end
