module Filters
  class Filter
    include Enumerable

    attr_reader :name, :selection_policy, :selected_values
    private :selection_policy, :selected_values

    def initialize(name, selected_value, selection_policy)
      @name = name
      @selection_policy = selection_policy
      @selected_values = selection_policy.selected_values_from(selected_value)
      @filter_options = []
    end

    def add_option(name, value)
      @filter_options << FilterOption.new(self, name, value, selected_values.include?(value))
    end

    def each(&block)
      @filter_options.each(&block)
    end

    def selected_options
      select(&:selected?)
    end
    
    def current_value
      param_string(selected_options.map(&:value))
    end

    def value_after_toggle_for_filter(filter_option)
      param_string(value_after_toggle_for(filter_option))
    end

    private
    def base_for_new_values
      selection_policy.base_for_new_values(selected_values)
    end

    def value_after_toggle_for(filter_option)
      filter_option.selected? ? base_for_new_values - [filter_option.value] : base_for_new_values + [filter_option.value]
    end
    
    def param_string(values)
      values.empty? ? "" : "#{name}:#{values.join(",")}"
    end
  end
end
