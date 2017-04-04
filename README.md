Oystercard Challenge
==================

Introduction
-------
The following programme is a solution to the 'Oystercard Challenge', which requires a card object to be created that ultimately permits the user to use the London underground train network.

The card itself is a store of value and grants access both to and from stations ("touch in" and "touch out"). A user can upload 'money' on to a card, and in order to touch in to a station a user must have the minimum fare uploaded. In order to exit from the destination station, a user touches out, upon which, a fair is calculated and deducted from the card's balance.

The fare calculated is based on the minimum fare, plus the difference between the zones of the entry and exit station. However, a penalty charge, rather than the normal fare, is enforced under two scenarios:
1. Touching in consecutively.
2. Touching out in succession.

Each journey a user makes is logged, and is begun by touching in and ended by touching out. A user is able to view their journey history, which returns both the entry and exit station of each journey. Incomplete journeys are also logged.

The programme should satisfy several pre specified user stories, which are detailed below:
```
In order to use public transport
As a customer
I want money on my card

In order to keep using public transport
As a customer
I want to add money to my card

In order to protect my money
As a customer
I don't want to put too much money on my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

In order to get through the barriers
As a customer
I need to touch in and out

In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey

In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

In order to pay for my journey
As a customer
I need to know where I've travelled from

In order to know where I have been
As a customer
I want to see to all my previous trips

In order to know how far I have travelled
As a customer
I want to know what zone a station is in

In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

In order to be charged the correct amount
As a customer
I need to have the correct fare calculated
```

Method
------------------
In order to solve this challenge, I followed the tenets of Test Driven Development (TDD) and the Behaviour-Driven Development (BDD) cycle.

This resulted in first creating a domain model for each user story, then writing feature tests for that story, followed by its constituent unit tests, and then practicing the red-green-refactor method.

To ensure that each aspect of the programme was thoroughly tested, the use of mocks and stubs were used throughout.

Note: Both the user story tests and unit tests are contained within the 'spec' folder. These can be ran with the gem Rspec.

When touching in and out, an argument ('station') is required. Each station has its own object and therefore, needs to be instantiated before being referenced. A station object is initialized with an argument 'name'. The 'name' argument that is passed is referenced against a station hash, which contains all the underground stations on the London transport network, along with their corresponding zones. If the station name does not match one of that in the database, an error is raised. If the 'name' is valid, the station's corresponding zone is then returned and assigned to the instance variable 'zone'.

The list of stations was populated through the creation and referencing of a csv file ('TubeStations.csv'). The ['smarter CSV'](https://github.com/tilo/smarter_csv) gem was utilised to help process and convert the csv file into an array of hashes, which was then equated to the 'data' instance variable initialized in the 'Station' class. The first line of the csv file represents the keys of the hash. The remaining lines represent the values of those keys. Each line is an individual hash.

E.g. the csv file below would produce the array:

[{station: Action Town, zone: 3}, {station: Aldgate, zone: 1}]
```
1. Station,Zone
2. Acton Town,3
3. Aldgate,1
```

How to run
------------------
Initial steps:

1. The software has been written in the language Ruby. Therefore, to successfully run this programme, Ruby must first be installed.

  In order to install the current stable version of Ruby, run the following in your command line or install [Homebrew](https://brew.sh/):

  ```
  $ wget -O ruby-install-0.6.1.tar.gz https://github.com/postmodern/ruby-install/archive/v0.6.1.tar.gz
  $ tar -xzvf ruby-install-0.6.1.tar.gz
  $ cd ruby-install-0.6.1/
  $ sudo make install
  ```
2. Fork and clone this project onto your machine.
3. In the command line, run 'bundle init' followed by 'bundle install' to install the programme's required gems, which are listed in the gem file.
5. Launch a REPL (Read Evaluate Print Loop), such as IRB, to allow you to run the programme.
6. Running it... Once your selected REPL is open, an extremely important first step is to require the oystercard.rb file. Once this is done you can then interact with the programme.

The code below demonstrates the following in order:
1. An error is raised when a user attempts to touch in without having the sufficient amount of balance required on a card.
2. The ability to upload 'money' to a card
3. Two stations (entry and exit) are instantiated with a valid station name.
4. A successful journey (touch in followed by a touch out.)
5. An incomplete journey (touching out in succession), which results in a penalty being charged.
6. The ability to view the user's complete journey history.

```
[1] pry(main)> require './lib/oystercard.rb'
=> true
[2] pry(main)> oyster = Oystercard.new
=> #<Oystercard:0x007ffbd43328b8
 @balance=0,
 @journey_log=
  #<JourneyLog:0x007ffbd43327f0
   @journey_class=Journey,
   @journeys=[],
   @travelling=false>>
[3] pry(main)> entry_station = Station.new('Aldgate')
=> #<Station:0x007ffbd3127a10 @name="Aldgate", @zone=1>
[4] pry(main)> exit_station = Station.new('Cockfosters')
=> #<Station:0x007ffbd31b7d18 @name="Cockfosters", @zone=5>
[5] pry(main)> oyster.touch_in(entry_station)
RuntimeError: Cannot pass. Insufficient funds!
[6] pry(main)> oyster.top_up(40)
=> 40
[7] pry(main)> oyster.balance
=> 40
[8] pry(main)> oyster.touch_in(entry_station)
=> true
[9] pry(main)> oyster.touch_out(exit_station)
=> nil
[10] pry(main)> oyster.balance
=> 35
[11] pry(main)> oyster.touch_out(exit_station)
=> true
[12] pry(main)> oyster.view_journey_history
=> [{:entry_station=>"Aldgate", :exit_station=>"Cockfosters"},
 {:entry_station=>#<Station:0x007ffbd3127a10 @name="Aldgate", @zone=1>,
  :exit_station=>#<Station:0x007ffbd31b7d18 @name="Cockfosters", @zone=5>},
 {:entry_station=>nil,
  :exit_station=>#<Station:0x007ffbd31b7d18 @name="Cockfosters", @zone=5>}]
[13] pry(main)> oyster.balance
=> 29
```
