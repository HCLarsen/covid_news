require "./daily_news/*"
require "./dir.cr"

module DailyNews
  VERSION = "0.1.0"

  def self.run
    desktop = Dir.home + "/Desktop"
    news_file = desktop + "/news.txt"
    date = Time.local.to_s("%Y-%m-%d")

    output = "Daily Report for #{date}"
    output += "\n*********************************\n"
    output +=  self.global_covid_report
    output += "\n*********************************\n"
    output +=  self.covid_report("CAN")
    output += "\n*********************************\n"
    output +=  self.covid_short_report("USA")
    output += "\n*********************************\n"
    output +=  self.covid_short_report("DNK")
    output += "\n*********************************\n"
    output +=  self.covid_short_report("KOR")
    output += "\n*********************************\n"
    output +=  self.covid_short_report("ESP")

    File.write(news_file, output)
  end
end

DailyNews.run
