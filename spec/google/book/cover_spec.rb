require 'spec_helper'

module Google
  module Book
    describe Cover do
      use_vcr_cassette 'google'

      subject { Request.find('deleuze').to_books.first.cover }

      %w{thumbnail small medium large extra_large}.each do |attribute|
        its(attribute) { should_not be_nil }
      end
    end
  end
end
