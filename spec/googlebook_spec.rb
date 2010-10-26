require 'spec_helper'

describe GoogleBook do
  use_vcr_cassette 'googlebook', :record => :new_episodes

  subject { GoogleBook.find('deleuze').first }

  %w{thumbnail info preview creator date description format
    identifier isbn publisher subject title}.each do |attribute|
    its(attribute) { should_not be_nil }
  end
end
