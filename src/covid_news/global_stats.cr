require "./stats.cr"

module CovidNews
  class GlobalStats < Stats
    WORLD_POPULATION = 7775154406

    def initialize
      history = Covidapi.getGlobalHistory
      @history = history.results
      @population = WORLD_POPULATION
    end
  end
end
