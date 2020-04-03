require "minitest/autorun"

require "/../src/daily_news/covid_report.cr"

class CovidReportTest < Minitest::Test
  def initialize(args)
    super(args)
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

  def test_prints_country_report
    assert_equal @canada_report, DailyNews.covid_report("CAN")
  end

  def test_prints_global_report
    assert_equal @global_report, DailyNews.global_covid_report
  end
end
