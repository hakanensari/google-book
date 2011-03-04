require 'cgi'
require 'httparty'

# A classy finder
module GoogleBook
  include HTTParty
  format :xml

  class << self

    # Query parameters passed on to Google
    attr_accessor :parameters

    # Total results for query
    attr_accessor :total_results

    # The query response
    attr_accessor :response

    # Queries the Google Book Search Data API.
    #
    # Optionally, specify a page and count to paginate through
    # the result set.
    #
    #   GoogleBook.find('deleuze', :page => 2, :count => 20)
    #
    def find(query, opts={})
      self.parameters = { 'q' => query }

      if opts[:page] && opts[:page].to_i > 0
        parameters['start-index'] = opts[:page]
      end

      if opts[:count] && (10..20).include?(opts[:count].to_i)
        parameters['max-results'] = opts[:count]
      end

      self.response = self.get(uri.to_s)

      self.total_results = response['feed']['openSearch:totalResults'].to_i

      response['feed']['entry'].map do |book|
        Book.new(
          Images.new(book['link'][0]['href']),
          book['link'][1]['href'],
          book['link'][2]['href'],
          [book['dc:creator']].flatten.join(', '),
          book['dc:date'],
          book['dc:description'],
          book['dc:format'],
          book['dc:identifier'],
          book['dc:publisher'],
          book['dc:subject'],
          [book['dc:title']].flatten.join(': '))
      end
    end

    private

    def query
      parameters.map { |k, v| "#{k}=#{CGI.escape(v.to_s)}" }.join('&')
    end

    def uri
      URI::HTTP.build :host   => 'books.google.com',
                      :path   => '/books/feeds/volumes',
                      :query  => query
    end
  end
end
