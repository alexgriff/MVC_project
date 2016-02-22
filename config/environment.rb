require 'sqlite3'
require 'bundler/setup'
Bundler.require



DB = {:conn => SQLite3::Database.new("../DB/project.db")}
# drop all tables if exist
sql = File.read("../DB/drop.sql")
DB[:conn].execute_batch(sql)

# creat all tables
sql = File.read("../DB/create.sql")
DB[:conn].execute_batch(sql)
DB[:conn].results_as_hash = true


# require all after establishing connection to
# database so interactive_record.rb has the DB
# constant
require_all '../app'
