# Tracks ongoing journies and calculates fares
require_relative "station"
require_relative "oystercard"

class Journey

  attr_reader :entry_station, :exit_station, :travelling
  MINIMUM_CHARGE = 1
  PENALTY_CHARGE = 6

  def initialize
    @travelling = false
  end

  def start(entry_station)
    @entry_station = entry_station
    self.travelling = true
  end

  def finish(exit_station)
    @exit_station = exit_station
    self.travelling = false
  end

  def reset
    self.entry_station = nil
    self.exit_station = nil
  end

  def complete?
    entry_station != nil && exit_station != nil
  end

  def fare
    complete? ? MINIMUM_CHARGE : PENALTY_CHARGE
  end

  private
  attr_writer :travelling, :entry_station, :exit_station


end
