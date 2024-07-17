require 'csv'
require 'json'
csv_file_path = 'data.csv'

table=CSV.read(csv_file_path)


def export_report(array)
  #Result in CSV
  File.write("ss.csv", array.map(&:to_csv).join)
  #Result in JSON
  first_line=array.shift
  a = array.map{|s| {first_line[0]=> s[0], first_line[1]=> s[1], first_line[2]=> s[2], first_line[3]=> s[3],first_line[4]=>s[4], first_line[5]=> s[5], first_line[6]=> s[6], first_line[7]=> s[7], first_line[8]=> s[8], first_line[9]=> s[9], first_line[10]=> s[10], first_line[11]=> s[11], first_line[12]=> s[12], first_line[13]=>s[13], first_line[14]=>s[14]} }
  hash_for_json={"report"=>{"name"=>"Companies with more than or exactly 100 employees", "data"=>a}}
  File.open('output_file.json', 'w') do |file|
    file.write(JSON.pretty_generate(hash_for_json))
  end
end

def first_report(table)
  array_of_companies=[table[0]]
  for lines in 1...table.length
    if table[lines][2].to_i>=100
      array_of_companies<<table[lines]
    end
  end
  export_report(array_of_companies)
end

def second_report(table)
  numbers_of_componies=Hash.new(0)
  table.each do |row|
    numbers_of_componies[row[13]] += 1
  end
  puts numbers_of_componies
end

def third_report(table)
  compony_standings=Hash.new
  table.each do |row|
    if row[7]=="New York"
      compony_standings[row[3]]=row[9]
    end
  end
  new_campony_standings=compony_standings.sort_by{|k,v| v}.reverse
  puts new_campony_standings[0..9]
end
first_report(table)
second_report(table[1..table.length])
third_report(table)
