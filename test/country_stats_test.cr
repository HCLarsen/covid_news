require "minitest/autorun"

require "./webmocks"
require "/../src/daily_news/country_stats.cr"

class CountryStatsTest < Minitest::Test
  def initialize(args)
    super(args)
    @canada = CovidNews::CountryStats.new("CAN")
  end

  def test_initializes
    assert_equal "Canada", @canada.name
    assert_equal 36155487, @canada.population
    assert_equal 63, @canada.history.size
    assert_equal 2790, @canada.current.confirmed
  end

  def test_calculates_current_stats
    assert_equal 0.00008, @canada.infection_rate.round(5)
    assert_equal 0.009, @canada.mortality_rate.round(3)
    assert_equal "2020-03-24", @canada.last_date
  end

  def test_calculates_new_cases
    new_cases = @canada.new_cases
    assert_equal 62, new_cases.size
    assert_equal 0, new_cases["2020-01-23"]
    assert_equal 702, new_cases["2020-03-24"]
  end

  def test_calculates_curve
    assert_equal CovidNews::CountryStats::Curve::Increasing, @canada.curve
  end
end
