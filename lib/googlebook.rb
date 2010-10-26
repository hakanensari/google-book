require File.dirname(__FILE__) + '/googlebook/finder'

# A Ruby class in tight embrace with the Google Book Search Data API
class GoogleBook
  attr_accessor :thumbnail,
                :info,
                :preview,
                :creator,
                :date,
                :description,
                :format,
                :identifier,
                :publisher,
                :subject,
                :title

  def initialize(args={})
    args.each { |k, v| self.send "#{k}=", v }
  end

  def isbn
    identifier.detect { |i| i.match(/ISBN:([0-9]{13})/) }; $1
  end
end
