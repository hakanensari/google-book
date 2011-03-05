require 'spec_helper'

module Google
  module Book
    describe Struct do
      use_vcr_cassette 'google'

      let(:book) do
        Struct.new
      end

      subject { Request.find('deleuze').to_books.first }

      %w{cover info preview creators date description formats
        identifiers isbn publisher subjects titles}.each do |attribute|
        its(attribute) { should_not be_nil }
      end

      describe "#formatted_creators" do
        it "should concatenate creators" do
          book.creators = ['Deleuze', 'Guattari']
          book.formatted_creators.should eql 'Deleuze, Guattari'
        end
      end

      describe "#formatted_formats" do
        it "should concatenate formats" do
          book.formats = ['foo', 'bar']
          book.formatted_formats.should eql 'foo, bar'
        end

        it "should drop the word book" do
          book.formats = ['foo', 'book']
          book.formatted_formats.should eql 'foo'
        end
      end

      describe "#formatted_publisher" do
        it "should drop Inc at the end of the word" do
          book.publisher = 'Publisher Inc'
          book.formatted_publisher.should eql 'Publisher'

          book.publisher = 'Random House, Inc.'
          book.formatted_publisher.should eql 'Random House'
        end

        it "should format Intl" do
          book.publisher = 'Continuum Intl'
          book.formatted_publisher.should eql 'Continuum International'
        end

        it "should format Pr" do
          book.publisher = 'Polity Pr'
          book.formatted_publisher.should eql 'Polity Press'
        end

        it "should format Pub" do
          book.publisher = 'Rowman & Littlefield Pub'
          book.formatted_publisher.should eql 'Rowman & Littlefield Publishers'
        end

        it "should format Pub Group" do
          book.publisher = 'Continuum International Pub Group'
          book.formatted_publisher.should eql 'Continuum International Publishing Group'
        end

        it "should format Univ in the middle of the word" do
          book.publisher = 'Columbia Univ Press'
          book.formatted_publisher.should eql 'Columbia University Press'
        end

        it "should format Univ at the end of the word" do
          book.publisher = 'Columbia Univ'
          book.formatted_publisher.should eql 'Columbia University'
        end
      end

      describe "#formatted_title" do
        it "should concatenate titles" do
          book.titles = ['Thousand Plateaus', 'Capitalism and Schizophrenia']
          book.formatted_title.should eql 'Thousand Plateaus: Capitalism and Schizophrenia'
        end
      end

      describe "#isbn" do
        it "should return the ISBN" do
          book.identifiers = ['8cp-Z_G42g4C','ISBN:0192802380']
          book.isbn.should eql '9780192802385'
        end

        it "should return nil if no ISBN is available" do
          book.identifiers = []
          book.isbn.should eql nil
        end
      end
    end
  end
end
