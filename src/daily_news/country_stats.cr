require "covidapi"
require "rest_countries"

module DailyNews
  class CountryStats
    getter name : String
    getter population : Int32
    getter history : Hash(String, Covidapi::Result)

    def initialize(country_code : String)
      country = RestCountries.getCountryByCode(country_code)
      history = Covidapi.getCountryHistory(country_code)
      @name = country.name
      @population = country.population
      @history = history.results
    end

    def current : Covidapi::Result
      @history.last_value
    end
  end
end
