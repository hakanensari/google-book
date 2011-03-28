module Google
  module Book
    class Cover
      def initialize(url)
        @url = url
      end

      def thumbnail
        urlify(5)
      end

      def small
        urlify(1)
      end

      def medium
        urlify(2)
      end

      def large
        urlify(3)
      end

      def extra_large
        urlify(6)
      end

      private

      def urlify(zoom)
        @url.
          gsub('zoom=5', "zoom=#{zoom}").
          gsub('&edge=curl', '')
      end
    end
  end
end
