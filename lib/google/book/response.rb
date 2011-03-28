require 'google/book/entry'

module Google
  module Book
    class Response
      include Enumerable

      def initialize(hash)
        @feed = hash['feed']
      end

      def each(&block)
        members.each do |member|
          block.call(Entry.new(member))
        end
      end

      def total_results
        @feed['openSearch:totalResults'].to_i
      end

      private

      def members
        if total_results == 0
          []
        else
          [@feed['entry']].flatten
        end
      end
    end
  end
end
