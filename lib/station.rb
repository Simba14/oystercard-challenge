# Stores list of stations names and respective zones
require 'smarter_csv'

class Station

  attr_reader :name, :zone

  def initialize(name)
    @name = name
    @zone = lookup
  end

   #user enters station name as an argument, station class looks up zone in data variable
  private

  def lookup
    data = SmarterCSV.process('./TubeStations.csv')
    correct_zone = data.select { |hash| hash[:station] == name }
    raise "Access denied: invalid station" if !correct_zone[0]
    correct_zone[0].values[1]
  end

end
