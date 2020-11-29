require "email"

require "./covid_news/*"
require "./dir.cr"

module CovidNews
  VERSION = "0.1.0"

  def self.email_report
    report = self.report(["CAN"], ["USA", "DNK"])

    email = EMail::Message.new
    email.from    ENV["EMAILFROM"]
    email.to      ENV["EMAILTO"]
    email.subject "Daily Report"
    email.message report

    client.start do
      send(email)
    end
  end

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

  def self._setup_email
    config = EMail::Client::Config.new(ENV["EMAILSERVER"], ENV["PORT"].to_i)
    config.use_tls(EMail::Client::TLSMode::STARTTLS)
    config.use_auth(ENV["EMAILFROM"], ENV["PASSWORD"])

    client = EMail::Client.new(config)
  end

  def self.run
    desktop = Dir.home + "/Desktop"
    news_file = desktop + "/news.txt"

    report = self.report(["CAN"], ["USA", "DNK"])
    File.write(news_file, report)
  end
end
