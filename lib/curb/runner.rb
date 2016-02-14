require 'singleton'

module Curb
  class Runner
    include Singleton

    def initialize
      @features = []
      @handlers = []
    end

    def call
      failed_tests = []
      total_time = 0

      @features.each do |feature|
        puts "-"*80
        puts "Feature: #{feature.phrase}"
        puts "-"*80

        feature.scenarios.each do |scenario|
          puts "Scenario: #{scenario.phrase}"

          scenario.steps.each do |step|
            puts "#{step.type.capitalize} #{step.phrase}"

            handler = @handlers.find do |handler|
              handler.test(step.phrase)
            end

            if handler.nil?
              puts "\tNo handler defined. Skipping"
              next
            end

            handler_start = Time.now

            begin
              handler.call(step.phrase)
              puts "\tPassed"
            rescue => e
              failed_tests << [feature, step, e]
              puts "\tFailed"
            end

            handler_end = Time.now

            time_taken = (handler_end - handler_start) * 1000

            total_time += time_taken

            puts "\tTime elapsed #{time_taken} milliseconds"
          end
        end
      end

      puts "\nTotal time elapsed #{total_time} milliseconds"

      puts "\n"
      puts "-"*80
      puts "Failed Tests (#{failed_tests.length})"
      puts "-"*80

      failed_tests.each.with_index do |test, i|
        feature, step, ex = test
        backtrace = ex.backtrace.join("\n\t\t")

        puts "#{i}) #{feature.phrase}: #{step.phrase}\n\t#{ex.class}: #{ex.message}\n\t#{backtrace}"
      end
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