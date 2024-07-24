# frozen_string_literal: true

require 'csv'
require 'json'

module Export

  def export_report_csv(array)
    File.write('ss.csv', array.map(&:to_csv).join)
  end

  def export_report_json(array)
    File.open('output_file.json', 'w') { |file| file.write(JSON.pretty_generate(array)) }
  end

  def making_hash
    first_line = table.shift
    table.map { |row| first_line.zip(row).to_h }
  end

  def making_array(hash)
    keys = []
    values = []
    hash.each do |line|
      keys << line.keys
      values << line.values
    end
    [keys.shift] + values
  end
end
