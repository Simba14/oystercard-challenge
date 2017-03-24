# Tracks ongoing journies and calculates fares
require_relative "station"
require_relative "oystercard"

class Journey

  attr_reader :entry_station, :exit_station
  MINIMUM_CHARGE = 1
  PENALTY_CHARGE = 6

  # def initialize
  #   @travelling = false
  # end

  def start(entry_station)
    # self.travelling = true
    self.entry_station = entry_station
  end

  def finish(exit_station)
    self.exit_station = exit_station
    # self.travelling = false
  end

  def reset
    self.entry_station = nil
    self.exit_station = nil
  end

  def complete?
    entry_station != nil && exit_station != nil
  end

  def fare
    complete? ? (MINIMUM_CHARGE + (entry_station.zone - exit_station.zone).abs) : PENALTY_CHARGE
  end

  private
  attr_writer :entry_station, :exit_station


end
