require "covidapi"

module CovidNews
  abstract class Stats
    enum Curve
      Increasing
      Steady
      Decreasing
    end

    getter population : Int64 = 0
    getter history = Hash(String, Covidapi::Result).new

    def current : Covidapi::Result
      @history.last_value
    end

    def confirmed : Array(Int32)
      @history.map do |k, v|
        v.confirmed
      end
    end

    def dates : Array(String)
      @history.keys
    end

    def last_date : String
      dates.last
    end

    def mortality_rate : Float64
      current.deaths / current.confirmed
    end

    def infection_rate : Float64
      current.confirmed / @population
    end

    def new_cases : Hash(String, Int32)
      new_cases = Array(Int32).new
      (1..confirmed.size).each do |n|
        if confirmed[n]?
          new_cases << confirmed[n] - confirmed[n-1]
        end
      end
      Hash.zip(dates[1..], new_cases)
    end

    def curve : Curve
      slopes = new_cases.values
      if slopes[-3] < slopes[-2] < slopes[-1]
        Curve::Increasing
      elsif slopes[-3] > slopes[-2] > slopes[-1]
        Curve::Decreasing
      else
        Curve::Steady
      end
    end
  end
end
