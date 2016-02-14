require 'singleton'
require 'paint'

module Curb
  class Runner
    include Singleton
    include Curb::RunnerDefaultPrintHooks

    def initialize
      @features = []
      @handlers = []
    end

    def call
      failed_tests = []
      total_time = 0

      @features.each do |feature|
        print_feature(feature)

        feature.scenarios.each do |scenario|
          print_scenario(scenario)

          scenario.steps.each do |step|
            print_step(step)

            handler = @handlers.find do |handler|
              handler.test(step.phrase)
            end

            if handler.nil?
              print_no_handler_found
              next
            end

            handler_start = Time.now

            begin
              handler.call(step.phrase)
              print_step_result(true)
            rescue => e
              failed_tests << [feature, step, e]
              print_step_result(false)
            end

            handler_end = Time.now

            time_taken = (handler_end - handler_start) * 1000
            total_time += time_taken

            print_step_time_taken(time_taken)
          end
        end
      end

      print_total_time_taken(total_time)

      print_failed_steps(failed_tests) unless failed_tests.empty?
    end

    def self.call
      instance.call
    end

    def reset
      @features = []
      @handlers = []
    end

    def self.reset
      instance.reset
    end

    def add_feature(feature)
      @features << feature
    end

    def self.add_feature(feature)
      instance.add_feature(feature)
    end

    def add_handler(handler)
      @handlers << handler
    end

    def self.add_handler(handler)
      instance.add_handler(handler)
    end

    def add_handlers(handlers=[])
      handlers.map { |handler| add_handler(handler) }
    end

    def self.add_handlers(handlers=[])
      instance.add_handlers(handlers)
    end
  end
end