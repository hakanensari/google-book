module Google
  module Book
    class Cover
      def initialize(url)
        @url = url
      end

      def thumbnail
        cover_url(5)
      end

      def small
        cover_url(1)
      end

      def medium
        cover_url(2)
      end

      def large
        cover_url(3)
      end

      def extra_large
        cover_url(6)
      end

      private

      def cover_url(zoom)
        @url.
          gsub('zoom=5', "zoom=#{zoom}").
          gsub('&edge=curl', '')
      end
    end
  end
end
