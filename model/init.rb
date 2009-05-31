# Here goes your database connection and options:

# Here go your requires for models:
# require 'model/user'

require 'sequel'

Sequel::Model.plugin(:schema)
DB = Sequel.sqlite('teewatch.db')

require 'model/tee'
require 'model/source'
