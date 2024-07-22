# frozen_string_literal: true

require 'csv'
require 'json'

module Export
  def export_report_csv(array)
    File.write('ss.csv', array.map(&:to_csv).join)
  end

  def export_report_json(array)
    File.open('output_file.json', 'w') do |file|
      file.write(JSON.pretty_generate(making_hash(array)))
    end
  end

  def making_hash(array)
    first_line = array.shift
    a = array.map do |s|
      { first_line[0] => s[0], first_line[1] => s[1], first_line[2] => s[2], first_line[3] => s[3],
        first_line[4] => s[4], first_line[5] => s[5], first_line[6] => s[6], first_line[7] => s[7],
        first_line[8] => s[8], first_line[9] => s[9], first_line[10] => s[10], first_line[11] => s[11],
        first_line[12] => s[12], first_line[13] => s[13], first_line[14] => s[14] }
    end
    { 'report' => { 'name' => 'Companies with more than or exactly 100 employees', 'data' => a } }
  end
end
