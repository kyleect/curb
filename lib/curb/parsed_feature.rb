module Curb
  class ParsedFeature
    def initialize(steps)
      @steps = steps
    end

    def phrase
      @steps.find { |i| i.type == :feature }.phrase
    end

    def steps
      @steps.reject { |i| i.type == :feature }
    end

    def steps_types
      steps.map(&:type)
    end

    def steps_phrases
      steps.map(&:phrase)
    end
  end
end