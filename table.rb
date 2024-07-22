# frozen_string_literal: true

require_relative 'export'

class Table
  include Export
  attr_accessor :table

  def initialize(table:)
    @table = table
  end

  def first_report
    array_of_companies = [@table[0]]
    (1...@table.length).each do |lines|
      array_of_companies << @table[lines] if @table[lines][2].to_i >= 100
    end
    export_report_csv(array_of_companies)
    export_report_json(array_of_companies)
  end

  def second_report
    @numbers_of_componies = Hash.new(0)
    @table.each do |row|
      @numbers_of_componies[row[13]] += 1
    end
    @numbers_of_componies
  end

  def third_report
    @compony_standings = {}
    @table.each do |row|
      @compony_standings[row[3]] = row[9] if row[7] == 'New York'
    end
    @new_campony_standings = @compony_standings.sort_by { |_k, v| v }.reverse
    @new_campony_standings[0..9]
  end
end
