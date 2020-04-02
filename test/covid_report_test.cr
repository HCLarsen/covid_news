require "minitest/autorun"

require "/../src/daily_news/covid_report.cr"

class CovidReportTest < Minitest::Test
  def initialize(args)
    super(args)
    @report = <<-REPORT
    COVID19 Report for Canada 2020-03-24
    Total Cases:      2790
    New Cases:        702
    Total Recovered:  0
    Total Deaths:     26
    Infection Rate:   0.008%
    Mortality Rate:   0.9%
    Curve:            Increasing
    REPORT
  end

  def test_prints_report
    assert_equal @report, DailyNews.covid_report("CAN")
  end
end
