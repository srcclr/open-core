require 'ostruct'

module DiscourseReports
  class Geoip
    def self.coordinates(ip_address)
      connection = GeoIP.new(Engine.root.join('data/geoip/GeoLiteCity.dat'))
      result = connection.city(ip_address) || OpenStruct.new(latitude: 47.6097, longitude: -122.3331)

      { lat: result.latitude, lon: result.longitude }
    end
  end
end
