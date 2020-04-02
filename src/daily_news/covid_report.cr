class String
  def self.print_stat(label : String, stat : String, position : Int32) : String
    spaces = position - label.size
    output = label + " " * spaces + stat
  end
end

struct Float64
  def to_percent(decimal = 3)
    value = (self * 100).round(decimal)
    string = sprintf("%f", value).rstrip("0") + "%"
  end
end

module DailyNews
  def self.covid_report(country_code : String) : String
    stats = DailyNews::CountryStats.new(country_code)
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
end
