require "minitest/autorun"

require "/../src/covid_news.cr"

class CovidNewsTest < Minitest::Test
  def initialize(args)
    super(args)

    date = Time.local.to_s("%Y-%m-%d")

    @long = <<-REPORT
    Daily Report for #{date}
    *********************************
    COVID19 Global Report for 2020-03-24
    Total Cases:      418678
    New Cases:        40131
    Total Recovered:  0
    Total Deaths:     18625
    Infection Rate:   0.005%
    Mortality Rate:   4.4%
    Curve:            Steady
    *********************************
    COVID19 Report for Canada 2020-03-24
    Total Cases:      2790
    New Cases:        702
    Total Recovered:  0
    Total Deaths:     26
    Infection Rate:   0.008%
    Mortality Rate:   0.9%
    Curve:            Increasing
    *********************************
    COVID19 Report for Ontario 2020-09-29
    Total Cases:      51085
    New Cases:        554
    Total Deaths:     2844
    7 Day Average:    476
    REPORT

    @short = <<-REPORT
    Daily Report for #{date}
    *********************************
    COVID19 Global Report for 2020-03-24
    Total Cases:      418678
    New Cases:        40131
    Total Recovered:  0
    Total Deaths:     18625
    Infection Rate:   0.005%
    Mortality Rate:   4.4%
    Curve:            Steady
    *********************************
    COVID19 Report for Canada 2020-03-24
    Total Cases:      2790
    New Cases:        702
    Mortality Rate:   0.9%
    Curve:            Increasing
    *********************************
    COVID19 Report for Ontario 2020-09-29
    Total Cases:      51085
    New Cases:        554
    Total Deaths:     2844
    7 Day Average:    476
    REPORT
  end

  def test_prints_full_report
    actual = CovidNews.report(["CAN"], [] of String)

    assert_equal @long, actual
  end

  def test_prints_full_short_report
    actual = CovidNews.report([] of String, ["CAN"])

    assert_equal @short, actual
  end
end
