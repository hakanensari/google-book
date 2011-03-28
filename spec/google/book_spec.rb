require 'spec_helper'

module Google
  describe Book do
    use_vcr_cassette 'google'

    describe "#search" do
      it "should escape parameters" do
        Book.search('foo bar')
        Book.send(:query).should include 'q=foo+bar'
      end

      it "should set the page" do
        Book.search('foo bar', :page => 2)
        Book.send(:query).should include 'start-index=2'
      end

      it "should set the number of results per page" do
        Book.search('foo bar', :count => 20)
        Book.send(:query).should include 'max-results=20'
      end

      it "should return a response" do
        Book.search('foo bar').should be_a Book::Response
      end
    end
  end
end
