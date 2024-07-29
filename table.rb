# frozen_string_literal: true

require_relative 'export'

class Table
  include Export

  def initialize(table:)
    @table = table
    @hash = making_hash
  end

  def call(type_of_call)
    case type_of_call
    when 'first_report'
      first_report
    when 'second_report'
      second_report
    when 'third_report'
      third_report
    else
      puts "Such report doesn't exist"
    end
  end

  private

  attr_accessor :table, :hash

  def report(for_csv, for_json)
    puts 'Please input the name of the CSV file'
    export_report_csv(for_csv)
    puts 'Please input the name of the JSON file'
    export_report_json(for_json)
  end

  def first_report
    new_array = []
    hash.each { |row| new_array << row if row['workers'].to_i >= 100 }
    report(making_array(new_array), { 'report' => { 'name' => 'Companies with more than or exactly 100 employees',
                                                    'data' => new_array } })
  end

  def second_report
    numbers_of_componies = Hash.new(0)
    hash.each { |row| numbers_of_componies[row['industry']] += 1 }
    report(numbers_of_componies, { 'report' => { 'name' => 'The number of companies that do industry',
                                                 'data' => numbers_of_componies } })
  end

  def third_report
    compony_standings = []
    making_hash.each { |row| compony_standings << row if row['city'] == 'New York' }
    new_campony_standings = compony_standings.sort_by { |line| line['revenue'].to_i }.reverse
    standings = new_campony_standings[0..9]
    report(making_array(standings), { 'report' => { 'name' => 'Top 10 companies in New York by revenue',
                                                    'data' => standings } })
  end
end
