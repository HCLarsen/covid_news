require "minitest/autorun"

require "./webmocks"
require "/../src/daily_news/global_stats.cr"

class GlobalStatsTest < Minitest::Test
  def initialize(args)
    super(args)
    @world = DailyNews::GlobalStats.new
  end

  def test_initializes
    assert_equal 7775154406, @world.population
    assert_equal 63, @world.history.size
    assert_equal 418678, @world.current.confirmed
  end

  def test_calculates_current_stats
    assert_equal 0.00005, @world.infection_rate.round(5)
    assert_equal 0.044, @world.mortality_rate.round(3)
    assert_equal "2020-03-24", @world.last_date
  end

  def test_calculates_new_cases
    new_cases = @world.new_cases
    assert_equal 62, new_cases.size
    assert_equal 99, new_cases["2020-01-23"]
    assert_equal 40131, new_cases["2020-03-24"]
  end

  def test_calculates_curve
    assert_equal DailyNews::CountryStats::Curve::Steady, @world.curve
  end
end
