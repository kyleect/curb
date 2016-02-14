require 'paint'

module Curb
  module RunnerDefaultPrintHooks
    def print_feature(feature)
      puts "-"*80
      puts "#{Paint['Feature:', :bold]} #{feature.phrase}"
      puts "-"*80
      puts "\n"
    end

    def print_scenario(scenario)
      puts "#{Paint['Scenario:', :bold]} #{scenario.phrase}"
      puts "-"*80+"\n\n"
    end

    def print_step(step)
      puts "#{Paint[step.type.capitalize, :bold, :cyan]} #{step.phrase}"
    end

    def print_no_handler_found
      puts "#{Paint['No handler defined. Skipping.', :yellow]}\n\n"
    end

    def print_step_result(result)
      if result
        puts Paint["Passed", :green]
      else
        puts Paint["Failed", :red]
      end
    end

    def print_step_time_taken(time_taken)
      puts "#{time_taken.round(3)} milliseconds\n\n"
    end

    def print_total_time_taken(total_time)
      puts "Total: #{total_time.round(3)} milliseconds\n\n"
    end

    def print_failed_steps(failed_tests)
      puts "-"*80
      puts "Failed Tests (#{failed_tests.length})"
      puts "-"*80

      failed_tests.each.with_index do |test, i|
        feature, step, ex = test
        backtrace = ex.backtrace.join("\n\t\t")

        puts "#{i}) #{feature.phrase}: #{step.phrase}\n\t#{Paint[ex.class, :red]}: #{ex.message}\n\t#{backtrace}"
      end
    end
  end
end