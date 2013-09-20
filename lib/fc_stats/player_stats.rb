require 'rubygems'
require 'mechanize'

module FcStats
	### Not yet implemented 
  class PlayerStats 
	def self.get_squad_stats club
	  puts "Get squad stats"
	  club_page = get_club club
	  club_page.links.each do |link|
	    puts link.text if link.text == "Squad stats"
	  end
	end
  end
end
