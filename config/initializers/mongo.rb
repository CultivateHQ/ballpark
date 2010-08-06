if ENV['MONGOHQ_URL']
  MongoMapper.config = {RAILS_ENV => {'uri' => ENV['MONGOHQ_URL']}}
  MongoMapper.connect(RAILS_ENV)
else
  MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
  MongoMapper.database = "enigma-#{Rails.env}"
end

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect_to_master if forked
   end
end

