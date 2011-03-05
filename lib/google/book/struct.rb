module Google
  module Book
    class Struct< Struct.new :cover,
                             :info,
                             :preview,
                             :creators,
                             :date,
                             :description,
                             :formats,
                             :identifiers,
                             :publisher,
                             :subjects,
                             :titles

      include Bookland

      def formatted_creators
        creators.join(', ')
      end

      def formatted_formats
        formats.reject do |format|
          format == 'book'
        end.join(', ')
      end

      def formatted_publisher
        publisher.
          gsub(/[ ,]+Inc.?$/, '').
          gsub(/[ ,]+Llc.?$/i, '').
          gsub(/[ ,]+Ltd.?$/, '').
          gsub(/Intl( |$)/) { "International#{$1}" }.
          gsub(/Pr( |$)/) { "Press#{$1}" }.
          gsub(/ Pub$/, ' Publishers').
          gsub(/ Pubns$/, ' Publications').
          gsub('Pub Group', 'Publishing Group').
          gsub(/Univ( |$)/) { "University#{$1}" }
      end

      def formatted_title
        titles.join(': ')
      end

      def isbn
        identifiers.detect do |identifier|
          identifier.match(/ISBN:([0-9X]{10,13})/)
        end

        ISBN.to_13($1) rescue nil
      end
    end
  end
end
