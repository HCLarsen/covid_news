require "minitest/autorun"

require "/../src/daily_news/country_stats.cr"

class CountryStatsTest < Minitest::Test
  def test_initializes
    canada = DailyNews::CountryStats.new("CAN")
    assert_equal "Canada", canada.name
    assert canada.population.is_a? Int32
    assert canada.history.size > 0
    assert canada.current.is_a? Covidapi::Result
  end
end
