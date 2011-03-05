require 'spec_helper'

module Google
  module Book
    describe Response do
      use_vcr_cassette 'google'

      it "should set total results" do
        response = Request.find('deleuze')
        response.total_results.should > 0
      end

      it "should return books" do
        response = Request.find('deleuze')
        books = response.to_books

        books.first.should be_a Struct
      end

      it "should handle single matches" do
        Request.find('9780826490780').to_books.first.should be_a Struct
      end

      it "should handle an empty query" do
        Request.find('').to_books.should be_empty
      end
    end
  end
end
