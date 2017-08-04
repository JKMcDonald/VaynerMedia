require_relative 'data'
require_relative 'data_parser'
require 'pry'
require 'json'


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

  total = []
  combined_data.select do |person| 
    if person[0].has_hair_color("purple")
      total << person[1].spend.to_i
    end
  end
  puts "spent #{total.reduce(:+)} on people with purple hair"


 
  new_set = data2.each_with_object(Hash.new(0)) { |row,counts| counts[row.campaign_id] += 1 }

counter = 0
  new_set.each do |key, value|
    if value > 4
      counter +=1
    end
  end
  
  puts "#{counter} campaigns spent on more than 4 days"

 # new_set_H = data2.each_with_object(Hash.new(0)) { |row,counts| counts[row.actions["H"]] && counts[row.actions[""action""]==""clicks""] += 1 }
 # p new_set_H

counter = 0
data2.each do |row|
  JSON.parse(row.actions).each do |hash1|
  if hash1.has_key?("H") && hash1.has_value?("clicks")
    counter +=1
  end
end
end
puts "Source H reported on clicks #{counter} times"

collection = []
data2.each do |row|
  JSON.parse(row.actions).each do |hash1|
  if hash1.has_value?("junk") || hash1.has_value?("noise")
    collection << hash1
  end
end
end
junk = {}
noise = {}
collection.each do |hash_|
  if hash_.values[1] == "junk"
    junk = junk.merge(hash_){ |k, a_value, b_value| a_value + b_value }
  elsif hash_.values[1] == "noise"
    noise = noise.merge(hash_){ |k, a_value, b_value| a_value + b_value }
  end
end

more_junk_than_noise = []
junk.each do |junk|
  noise.each do |noise|
  if junk[0] == noise[0]
    if junk[1] > noise[1]
      more_junk_than_noise << junk
    end
  end
  end
end
p more_junk_than_noise
