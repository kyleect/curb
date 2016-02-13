module Curb
  class ParsedStep

    attr_reader :type, :phrase

    def initialize(type, phrase)
      @type = type
      @phrase = phrase
    end

    def serialize
      {
        type: @type,
        phrase: @phrase
      }
    end

    def to_s
      serialize
    end
  end
end