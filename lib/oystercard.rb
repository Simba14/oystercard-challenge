class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :in_use, :journey_history

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE  = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @in_use = false
    @journey_history = []
  end

  def top_up(amount)
    raise "Cannot top up: maximum balance exceeded (£#{MAXIMUM_BALANCE})" if balance + amount > MAXIMUM_BALANCE
    self.balance += amount
  end

  def in_journey?
    self.in_use
  end

  def touch_in(station)
    raise "Cannot pass. Insufficient funds!" if balance < MINIMUM_BALANCE
    self.in_use = true
    self.entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    self.in_use = false
    self.exit_station = station
    self.add_to_journey_history
  end

  def add_to_journey_history
    self.journey_history << {entry_station: self.entry_station, exit_station: self.exit_station}

  end

  private
  attr_writer :balance, :entry_station, :exit_station, :in_use

  def deduct(fare)
    self.balance -= fare
  end

end
