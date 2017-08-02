# require 'active_record'


# Change the following to reflect your database settings
# ActiveRecord::Base.establish_connection(
#   adapter:  postgresql,
#   host:     localhost,
#   database: My_database
# )


# ActiveRecord::Base.establish_connection(
#    :adapter   => 'sqlite3',
#    :database  => './your_db.db'
# )

class DataObject 

  attr_reader :campaign_id, :audience, :impressions, :ad_type, :date, :spend, :actions

  def initialize(args = {})
    @campaign_id = args.fetch(:campaign_id, "no campiagn id")
    @audience = args.fetch(:audience, "no audience")
    @impressions = args.fetch(:impressions, 0)
    @ad_type = args.fetch(:ad_type, "no type")
    @date = args.fetch(:date, "no date")
    @spend = args.fetch(:spend, 0)
    @actions = args.fetch(:actions, "no actions")
  end

  def inject_instance_variables(other)
    other.instance_variables.each do |var|
      self.instance_variable_set(var, other.instance_variable_get(var))
    end
  end

  def has_hair_color(color)
    if self.audience.include?(color)
      self.spend
    end
  end

end

