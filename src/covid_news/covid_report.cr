require "ontario_covid"

class String
  def self.print_stat(label : String, stat : String, position : Int32) : String
    spaces = position - label.size
    output = label + " " * spaces + stat
  end
end

struct Float64
  def to_percent(decimal = 3)
    sprintf("%2.#{decimal}f%%", self * 100)
  end
end

module CovidNews
  def self.global_covid_report
    stats = CovidNews::GlobalStats.new
    date = stats.last_date

    report = "COVID19 Global Report for #{date}\n"
    report += String.print_stat("Total Cases:", stats.current.confirmed.to_s, 18) + "\n"
    report += String.print_stat("New Cases:", stats.new_cases.last_value.to_s, 18) + "\n"
    report += String.print_stat("Total Recovered:", stats.current.recovered.to_s, 18) + "\n"
    report += String.print_stat("Total Deaths:", stats.current.deaths.to_s, 18) + "\n"
    report += String.print_stat("Infection Rate:", stats.infection_rate.to_percent, 18) + "\n"
    report += String.print_stat("Mortality Rate:", stats.mortality_rate.to_percent(1), 18) + "\n"
    report += String.print_stat("Curve:", stats.curve.to_s, 18)
  end

  def self.country_report(country_code : String) : String
    stats = CovidNews::CountryStats.new(country_code)
    date = stats.last_date

    report = "COVID19 Report for #{stats.name} #{date}\n"
    report += String.print_stat("Total Cases:", stats.current.confirmed.to_s, 18) + "\n"
    report += String.print_stat("New Cases:", stats.new_cases.last_value.to_s, 18) + "\n"
    report += String.print_stat("Total Recovered:", stats.current.recovered.to_s, 18) + "\n"
    report += String.print_stat("Total Deaths:", stats.current.deaths.to_s, 18) + "\n"
    report += String.print_stat("Infection Rate:", stats.infection_rate.to_percent, 18) + "\n"
    report += String.print_stat("Mortality Rate:", stats.mortality_rate.to_percent(1), 18) + "\n"
    report += String.print_stat("Curve:", stats.curve.to_s, 18)
  end

  def self.covid_short_report(country_code : String) : String
    stats = CovidNews::CountryStats.new(country_code)
    date = stats.last_date

    report = "COVID19 Report for #{stats.name} #{date}\n"
    report += String.print_stat("Total Cases:", stats.current.confirmed.to_s, 18) + "\n"
    report += String.print_stat("New Cases:", stats.new_cases.last_value.to_s, 18) + "\n"
    report += String.print_stat("Mortality Rate:", stats.mortality_rate.to_percent(1), 18) + "\n"
    report += String.print_stat("Curve:", stats.curve.to_s, 18)
  end

  def self.ontario_covid_report : String
    stats = OntarioCovid.get_recent_status
    date = stats.latest_date
    latest = stats.latest

    report = "COVID19 Report for Ontario 2020-09-29\n"
    report += String.print_stat("Total Cases:", latest.total_cases.to_s, 18) + "\n"
    report += String.print_stat("New Cases:", latest.cases.to_s, 18) + "\n"
    report += String.print_stat("7 Day Average:", stats.seven_day_average.to_s, 18) + "\n"
    report += String.print_stat("Total Deaths:", latest.total_deaths.to_s, 18)
  end
end
