# coding: utf-8
require "logstash/devutils/rspec/spec_helper"
require_relative "./filter_data"

# Inspired by: http://johan.org.uk/sysadmin/blog/2013/01/25/testing-logstash-configs-with-rspec/

# Load the logstash filter config files
files = Dir['/etc/logstash/conf.d/*filter.conf']
@@configuration = String.new
files.sort.each do |file|
  @@configuration << File.read(file)
end

# Take each test case
FILTER_DATA.each do |input_type,tests|
  describe "#{input_type} inputs" do
    config(@@configuration)

    # Compare logstash output to expected output
    tests.each do |t|
      sample({"message" => "#{t[:in]}", "type" => "#{input_type}"}) do
        t[:out].each do |name,value|
          # If test fails, print log output for debugging purposes
          if subject[name] != value
            print "Failed output: #{subject.to_hash}\n"
          end
          insist { subject[name] } == value
        end
      end
    end
  end
end

