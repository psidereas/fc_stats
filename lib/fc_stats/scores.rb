require 'rubygems'
require 'mechanize'

SOURCE_URL = 'http://espnfc.com/league/_/id/eng.1/barclays-premier-league?cc=5901'

module FcStats
  class Scores

	def self.get_club club
	  begin
		club_page = get_page club
	  rescue
	  	raise "Club [#{club}] not found"
	  end
	  club_page 
	end

	def self.get_squad_stats club
	  puts "Get squad stats"
	  club_page = get_club club
	  club_page.links.each do |link|
	    puts link.text if link.text == "Squad stats"
	  end
	end

	def self.get_squad_results club
	  club_page = get_club club
	  results_page = agent.click(club_page.link_with text: "Fixtures/Results")
	  matches = {}
	  (results_page.search("tr.evenrow") + results_page.search("tr.oddrow")).each do |element|
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
	    matches
	end

	def self.get_all_squad_results
	  results_page = get_page 'Results'

	  matches = {}
	  results_page.search("div.mod-content").each do |content|
	    date = DateTime.parse(content.search('tr.stathead td').text)

	    (content.search("tr.evenrow") + content.search("tr.oddrow")).each do |element|
		  next if date > Date.today
		  arr = content.search('td a')
		  matches[date] = {
		    :home       => arr[0].text.strip,
		    :score      => arr[1].text.strip,
		    :visitor    => arr[2].text.strip,
		    :venue     => element.search('td[7]').text.strip
		  }
	    end
	  end

	    matches
	end

	private

	def self.agent
	  Mechanize.new { |a| a.follow_meta_refresh = true }
	end

	def self.get_page(page_id)
	  begin
	    agent.get(SOURCE_URL) do |page|
	      return  agent.click(page.link_with text: page_id)
	    end
	  rescue
	  	raise "Error retrieving page: [#{page_id}]"
	  end
	end

  end
end
