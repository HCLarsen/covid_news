require "./daily_news/*"

# TODO: Write documentation for `DailyNews`
module DailyNews
  VERSION = "0.1.0"

  def self.run
    puts "*********************************"
    puts self.global_covid_report
    puts "*********************************"
    puts self.covid_report("CAN")
    puts "*********************************"
    puts self.covid_short_report("USA")
    puts "*********************************"
    puts self.covid_short_report("DNK")
    puts "*********************************"
    puts self.covid_short_report("KOR")
    puts "*********************************"
    puts self.covid_short_report("ESP")
  end
end

DailyNews.run
