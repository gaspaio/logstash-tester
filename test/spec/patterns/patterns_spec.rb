# coding: utf-8
require_relative "../spec_helper"
require_relative "./patterns_data"

# For each pattern group in file
PATTERN_DATA.each do |pattern_type, patterns|
  describe "#{pattern_type} pattern" do
    # take each pattern
    patterns.each do |pattern, tests|

      describe pattern do
        # and run each test
        tests.each do |t|
          # No GrokParseFailure
          it "'#{t[:name]}' message should pass" do
            expect(grok_match(pattern, "#{t[:in]}")).to pass
          end
          # Expected fields are present
          it "'#{t[:name]}' should have all the expected fields" do
            t[:out].each do |name,value|
              expect(grok_match(pattern, "#{t[:in]}")).to include(name => value)
            end
          end

        end
      end
    end
  end
end

