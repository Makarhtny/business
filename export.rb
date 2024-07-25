# frozen_string_literal: true

require 'csv'
require 'json'

module Export

  def export_report_csv(array_with_results)
    File.write('ss.csv', array_with_results.map(&:to_csv).join)
  end

  def export_report_json(hash_with_results)
    File.open('output_file.json', 'w') { |file| file.write(JSON.pretty_generate(hash_with_results)) }
  end

  def making_hash
    first_line = table.shift
    table.map { |row| first_line.zip(row).to_h }
  end

  def making_array(hash_for_conversion_to_array)
    keys = []
    values = []
    hash_for_conversion_to_array.each do |line|
      keys << line.keys
      values << line.values
    end
    [keys.shift] + values
  end
end
