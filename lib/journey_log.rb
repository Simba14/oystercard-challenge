require_relative 'Journey'

class JourneyLog

  attr_reader :journey_class, :journeys

  def initialize(journey_class)
    @journey_class = journey_class
    @journeys = []
  end

  def start(entry_station)
    current_journey.start(entry_station)
  end

  def finish(exit_station)
    current_journey.finish(exit_station)
    self.journeys << { entry_station: current_journey.entry_station, exit_station: current_journey.exit_station }
    current_journey.reset 
  end


  private


  def current_journey
    @current_journey ||= @journey_class.new
  end


end
