# coding: utf-8
require_relative "./spec_helper"
require "json"

# Load pattern test cases
pattern_data = Dir[File.join(File.dirname(__FILE__), 'pattern_data/**/*.json')]

pattern_data.each do |data_file|
  # Load test case data from file
  @@test_case = JSON.parse(File.read(data_file))

  describe "#{@@test_case['name']} (#{@@test_case['pattern']}, #{File.basename(data_file)})" do
    @@test_case['cases'].each_with_index do |item,i|
      name = "##{i} - #{item["in"][0..25]}..."
      expected_fields = item["out"].keys
      pattern = @@test_case['pattern']

      it "'#{name}' shouldn't generate grokparsefailures" do
        expect(grok_match(pattern, item['in'])).to pass
      end

      # Expected fields are present, have expected value, and no other fields are present
      it "'#{name}' should be correct" do
        match_res = grok_match(pattern, item['in'])
        # Ignore logstash added fields. These are always present.
        result_fields = match_res.keys.select { |f| not ['@version', '@timestamp', 'message'].include?(f) }

        # test for missing fields in match output
        missing = expected_fields.select { |f| not result_fields.include?(f) }
        msg = "\nFields missing in pattern output: #{missing}\n\n--"
        expect(missing).to be_empty, msg

        # test for unexpected fields in match output
        extra = result_fields.select { |f| not expected_fields.include?(f) }
        msg = "\nUnexpected fields in pattern output: #{extra}\n\n--"
        expect(extra).to be_empty, msg

        # test for field values
        item['out'].each do |name,value|
          msg = "\nField mismatch: '#{name}'\nExpected: #{value}\nGot: #{match_res[name]}\n\n--"
          expect(match_res[name]).to eq(value), msg
        end
      end
    end
  end
end

