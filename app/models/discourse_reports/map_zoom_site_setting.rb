require_dependency 'enum_site_setting'

module DiscourseReports
  class MapZoomSiteSetting < EnumSiteSetting
    def self.valid_value?(val)
      valid_values.include? val
    end

    def self.values
      @values ||= valid_values.map {|x| {name: x, value: x.to_i} }
    end

    def self.valid_values
      [ '25', '50', '75', '100', '200', '350', '500', '1000']
    end

    private_class_method :valid_values
  end
end
