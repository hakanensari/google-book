module Google
  module Book
    class Response
      def initialize(hash)
        @feed = hash['feed']
      end

      def to_books
        @feed['entry'].map do |hash|
          book = Struct.new(
            Cover.new(hash['link'][0]['href']),
            hash['link'][1]['href'],
            hash['link'][2]['href'],
            [hash['dc:creator']].flatten,
            hash['dc:date'],
            hash['dc:description'],
            [hash['dc:format']].flatten,
            hash['dc:identifier'],
            hash['dc:publisher'],
            hash['dc:subject'],
            [hash['dc:title']].flatten)
        end
      end

      def total_results
        @feed['openSearch:totalResults'].to_i
      end
    end
  end
end
