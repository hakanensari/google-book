module GoogleBook
  class Book < Struct.new :images,
                          :info,
                          :preview,
                          :creator,
                          :date,
                          :description,
                          :format,
                          :identifier,
                          :publisher,
                          :subject,
                          :title

    def initialize(args={})
      args.each { |k, v| self.send "#{k}=", v }
    end

    def isbn
      @isbn ||= find_isbn
    end

    private

    def find_isbn
      identifier.detect { |i| i.match(/ISBN:([0-9]{13})/) }
      $1
    end
  end
end
