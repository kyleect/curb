require 'spec_helper'

describe Curb::StepHandler do
  before :each do
    @handler_ran = false
  end

  let(:step_handler) do
    Curb::StepHandler.new(/Hello, (.+)!/) do |name|
      @handler_ran = true
    end
  end

  describe :step_handler do
    before :each do
      step_handler.run("Hello, World!")
    end

    it :matched_and_ran do
      expect(@handler_ran).to eq true
    end
  end
end
