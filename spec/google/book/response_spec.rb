require 'spec_helper'

module Google
  module Book
    describe Response do
      use_vcr_cassette 'google'

      it "should set total results" do
        response = Book.search('deleuze')
        response.total_results.should > 0
      end

      it "should return entries" do
        response = Book.search('deleuze')
        response.first.should be_an Entry
      end

      context "when there is a single match" do
        it "should return entries" do
          Book.search('9780826490780').first.should be_an Entry
        end
      end

      it "should handle an empty query" do
        Book.search('').to_a.should be_empty
      end
    end
  end
end
