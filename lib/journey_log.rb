require_relative 'Journey'
# Begins  and finished individual journies, records journey history
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
    self.travelling = true
  end

  def finish(exit_station)
    current_journey.finish(exit_station)
    self.journeys[-1][:exit_station] = exit_station
    self.travelling = false
  end

  def false_finish(exit_station)
    self.journeys << { entry_station: nil, exit_station: exit_station}
  end

  def fare
    current_journey.fare
  end

  def reset
    current_journey.reset
  end

  private

  attr_writer :travelling

  def current_journey
    @current_journey ||= self.journey_class.new
  end


end
