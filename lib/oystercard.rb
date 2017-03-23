# Stores balance, enables journey to begin and end, and stores journey history
require_relative "station"
require_relative "journey_log"

class Oystercard

  attr_reader :balance, :journey_log

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @journey_log = JourneyLog.new(Journey)
  end

  def top_up(amount)
    raise "Cannot top up: maximum balance exceeded (£#{MAXIMUM_BALANCE})" if balance + amount > MAXIMUM_BALANCE
    self.balance += amount
  end

  def in_journey?
    journey_log.travelling
  end

  def touch_in(station)
    raise "Cannot pass. Insufficient funds!" if balance < MINIMUM_BALANCE
    deduct(Journey::PENALTY_CHARGE) if in_journey?
    self.journey_log.start(station)
  end

  def touch_out(station)
    if ! in_journey?
      deduct(Journey::PENALTY_CHARGE)
    else
      self.journey_log.finish(station)
      deduct(journey_log.fare)
    end
  end

  private
  attr_writer :balance, :journey_log

  def deduct(fare)
    self.balance -= fare
  end

end
