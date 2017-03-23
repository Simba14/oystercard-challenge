require_relative 'Journey'

class JourneyLog

  attr_reader :journey_class, :journeys, :travelling

  def initialize(journey_class)
    @journey_class = journey_class
    @journeys = []
    @travelling = false
  end

  def start(entry_station)
    current_journey.start(entry_station)
    @travelling = true
  end

  def finish(exit_station)
    current_journey.finish(exit_station)
    self.journeys << { entry_station: current_journey.entry_station, exit_station: current_journey.exit_station }
    # current_journey.reset
    @travelling = false
  end

  def fare
    current_journey.fare
  end


  private


  def current_journey
    @current_journey ||= @journey_class.new
  end


end
