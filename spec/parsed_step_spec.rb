require 'spec_helper'

describe Curb::ParsedStep do
  let(:parsed_step) { Curb::ParsedStep.new(:given, 'The application is open') }

  describe :parsed_step do
    describe :type do
      it :equals_given do
        expect(parsed_step.type).to eq :given
      end
    end
    
    describe :phrase do
      it :equals do
        expect(parsed_step.phrase).to eq 'The application is open'
      end
    end
  end
end
