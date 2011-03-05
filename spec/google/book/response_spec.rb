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
        books.first.should be_an_instance_of Struct
      end
    end
  end
end
