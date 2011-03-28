require 'spec_helper'

module Google
  module Book
    describe Entry do
      use_vcr_cassette 'google'

      let(:entry) do
        Entry.new({})
      end

      subject { Book.search('deleuze').first }

      %w{cover creators date description format info_url preview_url publisher
        subjects title isbn}.each do |attribute|
        it { should respond_to attribute }
      end

      describe "#creators" do
        it "should concatenate creators" do
          entry.instance_variable_set(:@hash, {
            'dc:creator' => ['Deleuze', 'Guattari']
          })

          entry.creators.should eql 'Deleuze, Guattari'
        end
      end

      describe "#format" do
        it "should concatenate formats" do
          entry.instance_variable_set(:@hash, {
            'dc:format' => ['foo', 'bar']
          })

          entry.format.should eql 'foo, bar'
        end

        it "should drop the word book" do
          entry.instance_variable_set(:@hash, {
            'dc:format' => ['foo', 'book']
          })

          entry.format.should eql 'foo'
        end
      end

      describe "#publisher" do
        it "should drop Inc at the end of the name" do
          entry.instance_variable_set(:@hash, {
            'dc:publisher' => 'Publisher Inc'
          })

          entry.publisher.should eql 'Publisher'
        end

        it "should drop Inc. at the end of the name" do
          entry.instance_variable_set(:@hash, {
            'dc:publisher' => 'Publisher Inc.'
          })

          entry.publisher.should eql 'Publisher'
        end

        it "should drop Llc at the end of the name" do
          entry.instance_variable_set(:@hash, {
            'dc:publisher' => 'Publisher Llc'
          })

          entry.publisher.should eql 'Publisher'
        end

        it "should drop Llc. at the end of the name" do
          entry.instance_variable_set(:@hash, {
            'dc:publisher' => 'Publisher Llc.'
          })

          entry.publisher.should eql 'Publisher'
        end

        it "should drop LLC at the end of the name" do
          entry.instance_variable_set(:@hash, {
            'dc:publisher' => 'Publisher LLC'
          })

          entry.publisher.should eql 'Publisher'
        end

        it "should drop Ltd at the end of the name" do
          entry.instance_variable_set(:@hash, {
            'dc:publisher' => 'Publisher Ltd'
          })

          entry.publisher.should eql 'Publisher'
        end

        it "should format Intl" do
          entry.instance_variable_set(:@hash, {
            'dc:publisher' => 'Publisher Intl'
          })

          entry.publisher.should eql 'Publisher International'
        end

        it "should format Pr" do
          entry.instance_variable_set(:@hash, {
            'dc:publisher' => 'Publisher Pr'
          })

          entry.publisher.should eql 'Publisher Press'
        end

        it "should format Pub at the end of the name" do
          entry.instance_variable_set(:@hash, {
            'dc:publisher' => 'Publisher Pub'
          })

          entry.publisher.should eql 'Publisher Publishers'
        end

        it "should format Pubns at the end of the name" do
          entry.instance_variable_set(:@hash, {
            'dc:publisher' => 'Publisher Pubns'
          })

          entry.publisher.should eql 'Publisher Publications'
        end

        it "should format Pub Group" do
          entry.instance_variable_set(:@hash, {
            'dc:publisher' => 'Publisher Pub Group'
          })

          entry.publisher.should eql 'Publisher Publishing Group'
        end

        it "should format Univ in the middle of the name" do
          entry.instance_variable_set(:@hash, {
            'dc:publisher' => 'Publisher Univ Press'
          })

          entry.publisher.should eql 'Publisher University Press'
        end

        it "should format Univ at the end of the name" do
          entry.instance_variable_set(:@hash, {
            'dc:publisher' => 'Publisher Univ'
          })

          entry.publisher.should eql 'Publisher University'
        end
      end

      describe "#title" do
        it "should concatenate titles" do
          entry.instance_variable_set(:@hash, {
            'dc:title' => ['Thousand Plateaus', 'Capitalism and Schizophrenia']
          })

          entry.title.should eql 'Thousand Plateaus: Capitalism and Schizophrenia'
        end
      end

      describe "#isbn" do
        it "should return the ISBN" do
          entry.instance_variable_set(:@hash, {
            'dc:identifier' => ['8cp-Z_G42g4C','ISBN:0192802380']
          })

          entry.isbn.should eql '9780192802385'
        end

        it "should return nil if no ISBN is available" do
          entry.instance_variable_set(:@hash, {
            'dc:identifier' => []
          })

          entry.isbn.should eql nil
        end
      end
    end
  end
end
