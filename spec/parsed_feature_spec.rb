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

    describe :scenarios do
      it :count do
        expect(parsed_feature.scenarios.length).to eq 1
      end
    end
  end
end
