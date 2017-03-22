class Oystercard

  attr_reader :balance, :entry_station

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE  = 1

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    raise "Cannot top up: maximum balance exceeded (£#{MAXIMUM_BALANCE})" if balance + amount > MAXIMUM_BALANCE
    self.balance += amount
  end



  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    raise "Cannot pass. Insufficient funds!" if balance < MINIMUM_BALANCE
    self.entry_station = station
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    self.entry_station = nil
  end

  private
  attr_writer :balance, :entry_station

  def deduct(fare)
    self.balance -= fare
  end

end
