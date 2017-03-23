require_relative 'Journey'

class JourneyLog

  attr_reader :journey_class, :travelling, :journeys

  def initialize(journey_class)
    @journey_class = journey_class
    @journeys = []
    @travelling = false
  end

  def start(entry_station)
    current_journey.start(entry_station)
    self.journeys << { entry_station: entry_station}
    @travelling = true
  end

  def finish(exit_station)
    current_journey.finish(exit_station)
    self.journeys[-1][:exit_station] = exit_station
    @travelling = false
  end

  def false_finish(exit_station)
    self.journeys << { entry_station: nil, exit_station: exit_station}
  end

  def fare
    current_journey.fare
  end


  private

  def current_journey
    @current_journey ||= @journey_class.new
  end


end
