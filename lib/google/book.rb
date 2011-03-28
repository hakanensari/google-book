require 'cgi'
require 'httparty'
require 'google/book/response'

module Google

  # A simple wrapper around the Google Book Search API.
  module Book
    include HTTParty
    format :xml

    class << self

      # The search parameters.
      attr_accessor :parameters

      # Queries the Google Book Search Data API. Takes a query string and an
      # optional options hash.
      #
      # The options hash respects the following members:
      #
      # * `:page`, which specifies the page.
      #
      # * `:count`, which specifies the number of results per page.
      def search(query, opts = {})
        self.parameters = { 'q' => query }
        parameters['start-index'] = opts[:page]  if opts[:page]
        parameters['max-results'] = opts[:count] if opts[:count]

        Response.new(get(url.to_s))
      end

      private

      def query
        parameters.
          map { |k, v| "#{k}=#{CGI.escape(v.to_s)}" }.
          join('&')
      end

      def url
        URI::HTTP.build(:host  => 'books.google.com',
                        :path  => '/books/feeds/volumes',
                        :query => query)
      end
    end
  end
end
