module Curb
  class StepHandler
    attr_reader :pattern

    def initialize(pattern, &block)
      @pattern = pattern
      @handler = block
    end

    def test(phrase)
      phrase =~ @pattern
    end

    def run(phrase)
      unless test(phrase)
        fail "Phrase '#{phrase}' did not match Step Handler's pattern #{@pattern}"
      end

      # Matched captures from pattern in phrase
      captures = phrase.match(@pattern).captures

      # Run the hander passing in matched captures
      @handler.call *captures
    end
  end
end