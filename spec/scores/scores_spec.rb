require 'spec_helper'

module FcStats
  describe '.get_club' do
    before do
      @scores = FcStats::Scores
    end
    
    it 'should raise an exception if club not found' do
      lambda { @scores.get_club "FakeClubName" }.should raise_exception
    end

    it 'should not raise an exception if club found' do
      lambda { @scores.get_club "Chelsea" }.should_not raise_exception
    end

    it 'should return a club page' do
      page = @scores.get_club 'Arsenal'
      page.is_a?(Mechanize::Page) == true 
    end
  end

  describe '.get_squad_results' do
    it 'should return a hash of match results' do
      pending
    end
  end

  describe '.get_all_squad_results' do
    it 'should return a hash od all clubs match results' do
      pending
    end
  end
end