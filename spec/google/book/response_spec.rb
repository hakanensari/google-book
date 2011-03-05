require 'spec_helper'

module Google
  module Book
    describe Response do
      use_vcr_cassette 'google'

      let(:response) do
        Request.find('deleuze')
      end

      it "should set total results" do
        response.total_results.should > 0
      end

      it "should return books" do
        books = response.to_books
        books.first.should be_a Struct
      end

      it "should handle single matches" do
        Request.find('9780826490780').to_books.first.should be_a Struct
      end
    end
  end
end
