require 'singleton'

module Curb
  class Runner
    include Singleton

    def initialize
      @features = []
      @handlers = []
    end

    def run
      @features.each do |feature|
        puts "Feature: #{feature.phrase}"

        feature.steps.each do |step|
          puts "#{step.type.capitalize}: #{step.phrase}"
          handlers = @handlers.select do |handler|
            handler.test(step.phrase)
          end

          handler = handlers.empty? ? Proc.new {} : handlers.first

          begin
            handler.call(step.phrase)
          rescue => e
            puts "\t Failed!"
          else
            puts "\tPassed!"
          end
        end
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