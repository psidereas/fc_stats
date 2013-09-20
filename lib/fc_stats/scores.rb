require 'rubygems'
require 'mechanize'

   SOURCE_URL = 'http://espnfc.com/league/_/id/eng.1/barclays-premier-league?cc=5901'

module FcStats
  class Scores

	def self.get_club club
	  puts "Get Club"
	  @agent = Mechanize.new { |a| a.follow_meta_refresh = true }
	  club_page = nil
	  begin
	  	@agent.get(SOURCE_URL) do |page|
	    	club_page =  @agent.click(page.link_with text: club)
	  	end
	  rescue
	  	raise "Club not found"
	  end
	  club_page 
	end

	def self.get_squad_stats club
	  puts "Get squad stats"
	  club_page = Scores.get_club club
	  club_page.links.each do |link|
	    puts link.text if link.text == "Squad stats"
	  end
	end

	def self.get_squad_fixtures club
	  puts "Get squad fixtures"
	  club_page = Scores.get_club club
	  fixtures_page = @agent.click(club_page.link_with text: "Fixtures/Results")
	  matches = {}
	  (fixtures_page.search("tr.evenrow") + fixtures_page.search("tr.oddrow")).each do |element|
	    date = DateTime.parse(element.search('td').text)
	    date = Date.new(Date.today.year + 1, date.month, date.day) if date < Date.new(Date.today.year, 8, 1)

	    next if date > Date.today
	    arr = element.search('td a')
	    matches[date] = {
	        :home       => arr[0].text.strip,
	        :score      => arr[1].text.strip,
	        :visitor    => arr[2].text.strip,
	        :attendance => element.search('td[6]').text.strip,
	        :league     => element.search('td[7]').text.strip
	    }
	  end
	    puts matches
	end

	def self.get_all_squad_fixtures
	  puts "Get all squad fixtures"
	  all_clubs_page = nil
	  @agent.get(SOURCE_URL) do |page|
	    all_clubs_page =  @agent.click(page.link_with text: "Fixtures")
	  end
	  matches = {}
	  (all_clubs_page.search("tr.evenrow") + all_clubs_page.search("tr.oddrow")).each do |element|
	    date = DateTime.parse(element.search('td').text)
	    date = Date.new(Date.today.year + 1, date.month, date.day) if date < Date.new(Date.today.year, 8, 1)

	    next if date > Date.today
	    arr = element.search('td a')
	    matches[date] = {
	        :home       => arr[0].text.strip,
	        :score      => arr[1].text.strip,
	        :visitor    => arr[2].text.strip,
	        :attendance => element.search('td[6]').text.strip,
	        :league     => element.search('td[7]').text.strip
	    }
	  end
	    puts matches
	end

  end
end
