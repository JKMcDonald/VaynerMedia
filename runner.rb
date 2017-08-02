require_relative 'data'
require_relative 'data_parser'


if ARGV.any?

  data1 = DataParser.parse('source1.csv')
  data2 = DataParser.parse('source2.csv')

combined_data = []
  data1.each do |dataset1|
    data2.each do |dataset2|
      if dataset1.campaign_id == dataset2.campaign_id
        combined_data << dataset1.inject_instance_variables(dataset2)
      else
        combined_data << dataset1
        combined_data << dataset2
      end
    end
  end
p combined_data

command = ARGV.first
options = ARGV[1..-1]


case command
when "purple"
  total = []
  purple_hair_spend = combined_data.select {|person| total << person.has_hair_color?(command)}
  puts "The total amount spent toward people with #{command} hair"
  purple_hair_spend.reduce(:+)
end
end
  