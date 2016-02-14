module Curb
  class ParsedFeature
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

            # Step index of current and next scenarios
            step_index = @steps.find_index { |i| i.phrase == scenario.phrase }
            next_step_index = @steps.find_index { |i| i.phrase == scenarios_steps[next_index] }

            # Steps starting with the scenario and all steps before the next scenario
            # The last step is removed from array as that is the next scenario
            if next_step_index.nil?
              scenario_steps = @steps[step_index..(@steps.length - 1)]
            else
              scenario_steps = @steps[step_index..(next_step_index - 1)]
            end

            # Return parsed scenario
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