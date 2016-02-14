module Curb
  class ParsedFeature
    attr_reader :steps

    def initialize(steps)
      @steps = steps
    end

    def phrase
      @steps.find { |i| i.type == :feature }.phrase
    end

    def scenarios
      scenarios_steps = @steps.select { |i| i.type == :scenario }

      @scenarios ||= scenarios_steps
        .each_with_index
        .reduce([]) do |scenarios, (scenario, index)|
          next_index = index + 1
          next_scenario = scenarios_steps[next_index]

          step_index = @steps.find_index { |i| i.phrase == scenario.phrase }

          if next_scenario.nil?
            scenario_steps = @steps[step_index..(@steps.length - 1)]
          else
            next_step_index = @steps.find_index { |i| i.phrase == next_scenario.phrase }
            scenario_steps = @steps[step_index..(next_step_index - 1)]
          end
          
          scenarios << Curb::ParsedScenario.new(scenario_steps)

          scenarios
        end

      @scenarios
    end

    def steps_types
      @steps.map(&:type)
    end

    def steps_phrases
      @steps.map(&:phrase)
    end
  end
end