require 'cgi'
require 'httparty'

# A classy finder
class GoogleBook
  include HTTParty
  format :xml

  class << self
    # Query parameters passed on to Google
    attr_accessor :parameters

    # Total results for last query
    attr_accessor :total_results

    # Queries the Google Book Search Data API
    #
    # Optionally, specify a page and count to (sort-of) paginate through
    # the result set.
    #
    #   GoogleBook.find('deleuze', :page => 2, :count => 20)
    #
    def find(query, opts={})
      self.parameters           = { 'q' => query }

      if opts[:page] && opts[:page].to_i > 0
        parameters['start-index'] = opts[:page]
      end

      if opts[:count] && (10..20).include?(opts[:count].to_i)
        parameters['max-results'] = opts[:count]
      end

      response = self.get(uri.to_s)
      self.total_results = response['feed']['openSearch:totalResults'].to_i
      response['feed']['entry'].map do |book|
        new :thumbnail    => book['link'][0]['href'],
            :info         => book['link'][1]['href'],
            :preview      => book['link'][2]['href'],
            :creator      => book['dc:creator'],
            :date         => book['dc:date'],
            :description  => book['dc:description'],
            :format       => book['dc:format'],
            :identifier   => book['dc:identifier'],
            :publisher    => book['dc:publisher'],
            :subject      => book['dc:subject'],
            :title        => book['dc:title']
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
