require "email"

require "./covid_news/*"
require "./dir.cr"

module CovidNews
  VERSION = "0.1.0"

  def self.report(long : Array(String), short : Array(String))
    date = Time.local.to_s("%Y-%m-%d")

    output = "Daily Report for #{date}"
    output += "\n*********************************\n"
    output +=  CovidNews.global_covid_report
    short.each do |country|
      output += "\n*********************************\n"
      output +=  CovidNews.covid_short_report("#{country}")
    end
    long.each do |country|
      output += "\n*********************************\n"
      output +=  CovidNews.country_report("#{country}")
    end
    output += "\n*********************************\n"
    output += CovidNews.ontario_covid_report

    output
  end

  def self.run
    desktop = Dir.home + "/Desktop"
    news_file = desktop + "/news.txt"

    report = self.report(["CAN"], ["USA", "DNK"])
    File.write(news_file, report)
  end
end
