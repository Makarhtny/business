# frozen_string_literal: true

require_relative 'table'
require_relative 'export'

csv_file_path = 'data.csv'

new_table = Table.new(table: CSV.read(csv_file_path))
new_table.first_report
