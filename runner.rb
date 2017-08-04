require_relative 'data'
require_relative 'data_parser'
require 'pry'


if ARGV.any?

  data1 = DataParser.parse('source1.csv')
  data2 = DataParser.parse('source2.csv')

#make a new array of the two parsed CSV files where the corresponding campaign_id's group them into nested arrays
combined_data = []
  data1.each do |dataset1|
    data2.each do |dataset2|
      if dataset1.campaign_id == dataset2.campaign_id
        combined_data << [dataset1, dataset2]
      end
    end
  end


command = ARGV.first
options = ARGV[1..-1]

#Case conditional where using ARGV to ask a question and prompt a certain response
case command
when "purple"
  total = []
  combined_data.select do |person| 
    if person[0].has_hair_color(command)
      total << person[1].spend.to_i
    end
  end
  puts "The total amount spent toward people with #{command} hair"
  p total.reduce(:+)
when "4+ days"
  counter = 0
    data2.each do |row| 
      binding.pry
    if data2.count(row.campaign_id) > 4
      counter +=1
    end
  end
  puts "#{counter} campaigns spent on 4 + days"
end
end
  