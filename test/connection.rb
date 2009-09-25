print "Using native MySQL\n"
require 'logger'

ActiveRecord::Base.logger = Logger.new("debug.log")

ActiveRecord::Base.configurations = {
  'test' => {
    :adapter  => 'mysql',
    :username => 'root',
    :encoding => 'utf8',
    :database => 'gold_record_test',
  },
}

ActiveRecord::Base.establish_connection 'test'
