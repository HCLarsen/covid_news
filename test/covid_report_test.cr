require "minitest/autorun"

require "/../src/daily_news/covid_report.cr"

class CovidReportTest < Minitest::Test
  def initialize(args)
    super(args)
    @ontario_report = <<-REPORT
    COVID19 Report for Ontario 2020-09-29
    Total Cases:      51085
    New Cases:        554
    Total Deaths:     2844
    7 Day Average:    476
    REPORT

    @canada_report = <<-REPORT
    COVID19 Report for Canada 2020-03-24
    Total Cases:      2790
    New Cases:        702
    Total Recovered:  0
    Total Deaths:     26
    Infection Rate:   0.008%
    Mortality Rate:   0.9%
    Curve:            Increasing
    REPORT

    @canada_short_report = <<-REPORT
    COVID19 Report for Canada 2020-03-24
    Total Cases:      2790
    New Cases:        702
    Mortality Rate:   0.9%
    Curve:            Increasing
    REPORT

    @global_report = <<-REPORT
    COVID19 Global Report for 2020-03-24
    Total Cases:      418678
    New Cases:        40131
    Total Recovered:  0
    Total Deaths:     18625
    Infection Rate:   0.005%
    Mortality Rate:   4.4%
    Curve:            Steady
    REPORT
  end

  def test_prints_ontario_report
    assert_equal @ontario_report, DailyNews.ontario_covid_report  
  end

  def test_prints_country_report
    assert_equal @canada_report, DailyNews.covid_report("CAN")
  end

  def test_prints_short_country_report
    assert_equal @canada_short_report, DailyNews.covid_short_report("CAN")
  end

  def test_prints_global_report
    assert_equal @global_report, DailyNews.global_covid_report
  end
end
