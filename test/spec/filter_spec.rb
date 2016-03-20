# coding: utf-8
require "logstash/devutils/rspec/spec_helper"
require "rspec/expectations"
require 'json'

# Load the test cases
filter_data = Dir[File.join(File.dirname(__FILE__), 'filter_data/**/*.json')]

# Load the logstash filter config files
files = Dir[File.join(File.dirname(__FILE__), 'filter_config/*filter.conf')]
@@configuration = String.new
files.sort.each do |file|
  @@configuration << File.read(file)
end

filter_data.each do |data_file|
  # Load test case from each file
  @@test_case = JSON.parse(File.read(data_file))

  describe "#{@@test_case['name']}" do
    config(@@configuration)
    input = @@test_case['fields']
    @@test_case['cases'].each_with_index do |item,i|
        input['message'] = item['in']
        expected = item["out"]
        expected_fields = expected.keys

        msg_header = "[#{File.basename(data_file)}##{i}]"

        sample(input) do
          lsresult = results[0]
          result_fields = lsresult.to_hash.keys.select { |i| not @@test_case['ignore'].include?(i) }

          # Test for presence of expected fields
          missing = expected_fields.select { |f| not result_fields.include?(f) }
          msg = "\n#{msg_header} Fields missing in logstash output: #{missing}"
          expect(missing).to be_empty, msg

          # Test for absence of unknown fields
          extra = result_fields.select { |f| not expected_fields.include?(f) }
          msg = "\n#{msg_header} Unexpected fields in logstash output: #{extra}\n\n--"
          expect(extra).to be_empty, msg

          # Test individual field values
          expected.each do |name,value|
            msg = "\n#{msg_header} Field mismatch: '#{name}'\nExpected: #{value}\nGot: #{lsresult[name]}\n\n--"
            expect(lsresult[name]).to eq(value), msg
          end
        end

    end
  end
end

