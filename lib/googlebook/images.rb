module GoogleBook
  class Images
    attr_accessor :url

    def initialize(url)
      self.url = url
    end

    def thumbnail
      url
    end

    def small
      zoom(1)
    end

    def medium
      zoom(2)
    end

    def large
      zoom(3)
    end

    private

    def zoom(level)
      url.gsub('zoom=5', "zoom=#{level}")
    end
  end
end
