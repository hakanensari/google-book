require 'spec_helper'

module GoogleBook
  describe "Finder module" do
    use_vcr_cassette 'googlebook'

    it "should escape parameters" do
      GoogleBook.find('foo bar')
      GoogleBook.send(:query).should include 'foo+bar'
    end

    it "should set page" do
      GoogleBook.find('foo bar', :page => 2)
      GoogleBook.send(:query).should include 'start-index=2'
    end

    it "should set number of results per page" do
      GoogleBook.find('foo bar', :count => 20)
      GoogleBook.send(:query).should include 'max-results=20'
    end

    it "should filter out invalid pages" do
      %w{-1 0 foo}.each do |page|
        GoogleBook.find('foo bar', :page => page)
        GoogleBook.send(:query).should_not include 'start-index'
      end
    end

    it "should filter out invalid counts" do
      %w{9 21 foo}.each do |count|
        GoogleBook.find('foo bar', :count => count)
        GoogleBook.send(:query).should_not include 'max-results'
      end
    end

    it "should set total results" do
      GoogleBook.find('deleuze')
      GoogleBook.total_results.should > 0
    end

    it "should return books" do
      GoogleBook.find('deleuze').first.should be_an_instance_of Book
    end
  end
end
