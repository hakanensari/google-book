require 'cgi'
require 'httparty'

module Google
  module Book
    module Request
      include HTTParty
      format :xml

      class << self
        attr_accessor :parameters

        # Queries the Google Book Search Data API.
        #
        # Optionally, specify a page and count to paginate through the
        # result set.
        #
        #   GoogleBook.find('deleuze', :page => 2, :count => 20)
        #
        def find(query, opts = {})
          self.parameters = { 'q' => query }
          parameters['start-index'] = opts[:page] if opts[:page]
          parameters['max-results'] = opts[:count] if opts[:count]

          Response.new(get(url.to_s))
        end

        private

        def query
          parameters.map { |k, v| "#{k}=#{CGI.escape(v.to_s)}" }.join('&')
        end

        def url
          URI::HTTP.build(:host  => 'books.google.com',
                          :path  => '/books/feeds/volumes',
                          :query => query)
        end
      end
    end
  end
end
