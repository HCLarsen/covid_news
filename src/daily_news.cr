require "email"

require "./daily_news/*"
require "./dir.cr"

module DailyNews
  VERSION = "0.1.0"

  def self.email_report
    report = self.report

    email = EMail::Message.new
    email.from    ENV["EMAILFROM"]
    email.to      ENV["EMAILTO"]
    email.subject "Daily Report"
    email.message report

    client.start do
      send(email)
    end
  end

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

  def self.email_setup
    config = EMail::Client::Config.new(ENV["EMAILSERVER"], ENV["PORT"].to_i)
    config.use_tls(EMail::Client::TLSMode::STARTTLS)
    config.use_auth(ENV["EMAILFROM"], ENV["PASSWORD"])

    client = EMail::Client.new(config)    
  end

  def self.run
    desktop = Dir.home + "/Desktop"
    news_file = desktop + "/news.txt"

    report = self.report
    File.write(news_file, report)
  end
end

DailyNews.email_report
