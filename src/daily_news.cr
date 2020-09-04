require "sendgrid"

require "./daily_news/*"
require "./dir.cr"

module DailyNews
  VERSION = "0.1.0"

  def self.report
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

    output
  end

  def self.email_report
    report = self.report
  end

  def self.run
    desktop = Dir.home + "/Desktop"
    news_file = desktop + "/news.txt"

    report = self.report
    File.write(news_file, report)
  end
end

DailyNews.run
