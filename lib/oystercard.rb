class Oystercard
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def return_balance
    balance
  end

  def top_up(amount)
    self.balance = amount + balance
  end

private
attr_reader :balance
attr_writer :balance

end
