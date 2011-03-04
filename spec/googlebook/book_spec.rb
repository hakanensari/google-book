require 'spec_helper'

module GoogleBook
  describe Book do
    use_vcr_cassette 'googlebook'

    subject { GoogleBook.find('deleuze').first }

    %w{images info preview creator date description format
      identifier isbn publisher subject title}.each do |attribute|
      its(attribute) { should_not be_nil }
    end

    context "images" do
      subject { GoogleBook.find('deleuze').first.images }

      %w{thumbnail small medium large}.each do |attribute|
        its(attribute) { should_not be_nil }
      end
    end
  end
end
