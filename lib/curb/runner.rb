require 'singleton'

module Curb
  class Runner
    include Singleton

    def initialize
      @features = []
      @handlers = []
    end

    def run
      failed_tests = []

      @features.each do |feature|
        puts "Feature: #{feature.phrase}"

        feature.steps.each do |step|
          puts "#{step.type.capitalize}: #{step.phrase}"

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
          rescue => e
            failed_tests << [feature, step, e]
          end

          handler_end = Time.now

          puts "\tTime elapsed #{(handler_end - handler_start)*1000} milliseconds"
        end
      end

      puts "\n"
      puts "Failed Tests"

      failed_tests.each.with_index do |test, i|
        feature, step, ex = test
        backtrace = ex.backtrace.join("\n\t\t")

        puts "\t#{i}) #{feature.phrase} - #{step.phrase}\n\t\t#{ex.class}: #{ex.message}\n\t\t#{backtrace}"
      end
    end

    def reset
      @features = []
      @handlers = []
    end

    def add_feature(feature)
      @features << feature
    end

    def add_handler(handler)
      @handlers << handler
    end

    def add_handlers(handlers=[])
      handlers.map { |handler| add_handler(handler) }
    end
  end
end