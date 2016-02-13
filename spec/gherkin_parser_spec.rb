require 'spec_helper'

describe Curb::GherkinParser do
  let(:feature) { IO.read(File.join(*[Dir.pwd, 'spec', 'example_project', 'features', 'example.feature'])) }
  let(:parsed_feature) { Curb::GherkinParser.(feature) }

  describe :parsed_feature do
    it(:phrase) do
      expect(parsed_feature.phrase).to eq 'An example feature for the GherkinParser'
    end
  end
end
