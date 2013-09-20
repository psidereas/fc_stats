# FcStats

FcStats gathers English Premier League (EPL) soccer stats. 

## Installation

Add this line to your application's Gemfile:

    gem 'fc_stats'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fc_stats

## Usage

To get specific club scores
FcStats::Scores.get_club_results 'ClubName'

To get all club scores
FcStats::Scores.get_all__results

### Not yet implemented ###
To get specific club player stats
FcStats::Scores.get_all_squad_stats 'ClubName'


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## TODOs

1. Write tests
2. Seperate the Mechanize initialization into it's own class
3. Implement the FcStats::Scores.get_all_squad_stats 'ClubName' to retrieve all 'ClubName' player stats
4. Implement retrieving specific player stats
5. Need greater fault tolerance/exception handling
6. Need 'ClubName' checking
