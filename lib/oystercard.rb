# Stores balance, enables journey to begin and end, and stores journey history
require_relative "station"
require_relative "journey_class"

class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journey_history, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journey = Journey.new
    @journey_history = []
  end

  def top_up(amount)
    raise "Cannot top up: maximum balance exceeded (£#{MAXIMUM_BALANCE})" if balance + amount > MAXIMUM_BALANCE
    self.balance += amount
  end

  def in_journey?
    journey.travelling
  end

  def touch_in(station)
    raise "Cannot pass. Insufficient funds!" if balance < MINIMUM_BALANCE
    deduct(Journey::PENALTY_CHARGE) if in_journey?
    self.journey = Journey.new
    self.journey.start(station)
  end

  def touch_out(station)
    self.journey.finish(station)
    deduct(journey.fare)
    self.adds_to_journey_history
    self.journey.reset
  end

  def adds_to_journey_history
    self.journey_history << {entry_station: self.journey.entry_station, exit_station: self.journey.exit_station}
  end

  private
  attr_writer :balance, :entry_station, :exit_station, :journey

  def deduct(fare)
    self.balance -= fare
  end

end
