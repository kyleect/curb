module Curb
  class ParsedScenario
    def initialize(steps)
      @steps = steps
    end

    def phrase
      @steps.find { |i| i.type == :scenario }.phrase
    end

    def steps
      @steps.reject { |i| i.type == :scenario }
    end

    def steps_types
      steps.map(&:type)
    end

    def steps_phrases
      steps.map(&:phrase)
    end
  end
end