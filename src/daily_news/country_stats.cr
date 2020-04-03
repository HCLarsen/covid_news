require "rest_countries"

require "./stats.cr"

module DailyNews
  class CountryStats < Stats
    getter name : String

    def initialize(country_code : String)
      super(country_code)
      country = RestCountries.getCountryByCode(country_code)
      @name = country.name
      @population = country.population
    end
  end
end
