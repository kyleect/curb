module Curb
  class GherkinParser
    def self.call(feature)
      new(feature).send(:parse)
    end
    
    private

    private_class_method :new

    def initialize(feature)
      @feature = feature
    end

    def parse
      steps = @feature
        .split(/\n+/)
        .map do |line|
          parse_line_as_step(line)
        end
        .reduce([]) do |steps, step|
          steps << step
        end

      begin
        validate_parse(steps)
      rescue => e
        raise e
      end

      Curb::ParsedFeature.new(steps)
    end

    def parse_line_as_step(line)
      split_char = line.include?(':') ? ':' : ' '
      type, *phrase = line.split(split_char)

      Curb::ParsedStep.new(type.downcase.strip.to_sym, phrase.join(' ').strip)
    end

    def validate_parse(steps)
      unless steps.select { |i| i.type == :feature }.length == 1
        raise "More than one feature step defined in feature file"
      end
    end
  end
end