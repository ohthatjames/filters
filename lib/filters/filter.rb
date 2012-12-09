module Filters
  class Filter
    include Enumerable

    attr_reader :name, :selection_policy, :selected_values
    private :selection_policy, :selected_values

    def initialize(name, current_param_value, selection_policy)
      @name = name
      @selection_policy = selection_policy
      @selected_values = selection_policy.selected_values_from(current_param_value)
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
    
    def current_param
      param_string(selected_values)
    end

    def param_after_toggle_for(filter_option)
      param_string(param_value_after_toggling(filter_option))
    end

    private
    def base_for_new_values
      selection_policy.base_for_new_values(selected_values)
    end

    def param_value_after_toggling(filter_option)
      filter_option.selected? ? base_for_new_values - [filter_option.value] : base_for_new_values + [filter_option.value]
    end
    
    def param_string(values)
      values.empty? ? "" : "#{name}:#{values.join(",")}"
    end
  end
end
