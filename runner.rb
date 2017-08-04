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

  total = 0
  combined_data.select do |person| 
    if person[0].has_hair_color("purple")
      total += person[1].spend.to_i
    end
  end
  puts "spent #{total} on people with purple hair"


 
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



#What was the total Cost per view for all video ads?
views = 0
spend = 0
data2.each do |row|
  counter = 0
  JSON.parse(row.actions).each do |hash_info|
    if hash_info.has_value?("views")
        views += hash_info.values[0].to_i
        counter +=1
      end
  end 
  if counter > 0 
   spend += row.spend.to_i
  end
end

views
spend

301096/2267471 
puts "13 cents for every view of a video add"

#How many source B Conversions were there for campaigns targeting NY?
newyork = []
data1.each do |row|
  if row.state_based_in("NY")
    newyork << row
  end
end

new_york_campaigns = []
data2.each do |row|
newyork.each do |campaign|
  if campaign.campaign_id == row.campaign_id
    new_york_campaigns << row
  end
end
end

conversions = 0
new_york_campaigns.each do |info|
JSON.parse(info.actions).each do |hash_data|
  if hash_data.has_value?("conversions") && hash_data.has_key?("B")
    conversions += hash_data.values[0].to_i
  end
end
end

p conversions

#Which combination of state and hair color had the best CPM? Divide the total number of impressions the ad will make by 1,000. For example, if your ad would make 10,000 impressions, you would divide 10,000 by 1,000 to get 10. 3. Divide the total cost of running the ad by the result from Step 2 to calculate the CPM for the ad. - smallbusiness.chron.com/calculate-cpm-787.html


total = {}
counter = 0
combined_data.each do |campaign|
  unless campaign[1].spend.to_i == 0 || campaign[0].impressions.to_i == 0
    if total.key?(campaign[0].campaign_id)
      total["#{campaign[0].campaign_id}"+"#{counter}"] = campaign[1].spend.to_i/(campaign[0].impressions.to_i/1000.0)
      counter += 1
    else
  total[campaign[0].campaign_id] = campaign[1].spend.to_i/(campaign[0].impressions.to_i/1000.0)
  end
  end
end
p total.min_by{|k,v| v}

#blue hair in Nevada gets the most bang for their buck