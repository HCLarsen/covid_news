require "rest_countries"

require "./stats.cr"

module DailyNews
  class CountryStats < Stats
    getter name : String

    def initialize(country_code : String)
      country = RestCountries.getCountryByCode(country_code)
      history = Covidapi.getCountryHistory(country_code)
      @name = country.name
      @history = history.results
      @population = country.population.to_i64
    end
  end
end
