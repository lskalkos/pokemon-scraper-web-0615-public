require 'bundler/setup'
# require 'sqlite3'
require 'open-uri'
require 'nokogiri'
require 'pry'

Bundler.require

require_relative "sql_runner"
require_relative "../lib/scraper"
require_relative "../lib/pokemon"
