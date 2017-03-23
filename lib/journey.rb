# Tracks ongoing journies and calculates fares
require_relative "station"
require_relative "oystercard"

class Journey

  attr_reader :entry_station, :exit_station, :travelling
  MINIMUM_CHARGE = 1
  PENALTY_CHARGE = 6

  def initialize(station)
    @entry_station = station
    @travelling = true
  end

  def finish(station)
    @exit_station = station
    self.travelling = false
  end

  def reset
    @entry_station = nil
    @exit_station = nil
  end

  def complete?
    entry_station != nil && exit_station != nil
  end

  def fare
    complete? ? MINIMUM_CHARGE : PENALTY_CHARGE
  end

  private
  attr_writer :travelling


end
