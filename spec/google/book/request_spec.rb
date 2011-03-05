require 'spec_helper'

module Google
  module Book
    describe Request do
      use_vcr_cassette 'google'

      it "should escape parameters" do
        Request.find('foo bar')
        Request.send(:query).should include 'foo+bar'
      end

      it "should set page" do
        Request.find('foo bar', :page => 2)
        Request.send(:query).should include 'start-index=2'
      end

      it "should set number of results per page" do
        Request.find('foo bar', :count => 20)
        Request.send(:query).should include 'max-results=20'
      end
    end
  end
end
