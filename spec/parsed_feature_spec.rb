require 'spec_helper'

describe Curb::ParsedFeature do
  let(:feature) { IO.read(File.join(*[Dir.pwd, 'spec', 'example_project', 'features', 'example.feature'])) }
  let(:parsed_feature) { Curb::GherkinParser.(feature) }

  describe :parsed_feature do
    describe :phrase do
      it :equals do
        expect(parsed_feature.phrase).to eq 'An example feature for the GherkinParser'
      end
    end

    describe :steps do
      describe :steps_types do |variable|
        it :ordered do
          expect(parsed_feature.steps_types).to eq [
            :scenario,
            :given,
            :and,
            :when,
            :and,
            :and,
            :then,
            :and
          ]
        end
      end

      describe :steps_phrases do |variable|
        it :ordered do
          expect(parsed_feature.steps_phrases).to eq [
            'Test scenario',
            'some precondition',
            'some other precondition',
            'some action by the actor',
            'some other action',
            'yet another action',
            'some testable outcome is achieved',
            'something else we can check happens too'
          ]
        end
      end
    end
  end
end
