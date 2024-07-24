# frozen_string_literal: true

require_relative 'export'

class Table
  include Export

  def initialize(table:)
    @table = table
  end

  def call(type_of_cal)
    case type_of_cal
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

  attr_accessor :table

  def first_report
    new_array = []
    making_hash.each do |row|
      new_array << row if row['workers'].to_i >= 100
    end
    export_report_csv(making_array(new_array))
    export_report_json({ 'report' => { 'name' => 'Companies with more than or exactly 100 employees',
                                       'data' => new_array } })
  end

  def second_report
    numbers_of_componies = Hash.new(0)
    making_hash.each do |row|
      numbers_of_componies[row['industry']] += 1
    end
    export_report_csv(numbers_of_componies)
    export_report_json({ 'report' => { 'name' => 'The number of companies that do industry',
                                       'data' => numbers_of_componies } })
  end

  def third_report
    compony_standings = []
    making_hash.each do |row|
      compony_standings << row if row['city'] == 'New York'
    end
    new_campony_standings = compony_standings.sort_by { |line| line['revenue'].to_i }.reverse
    standings = new_campony_standings[0..9]
    export_report_csv(making_array(standings))
    export_report_json({ 'report' => { 'name' => 'Top 10 companies in New York by revenue',
                                       'data' => standings } })
  end
end
