require_relative 'data'
require 'csv'
require 'date'

module DataParser
  def self.parse(filename)
    csv = CSV.foreach(filename, :headers => true, :header_converters => :symbol, :converters => :date_time)
    file_array = csv.to_a.map {|row| row.to_hash}
    file_array.map! do |data_info|
      DataObject.new(data_info)
    end
  end
end
