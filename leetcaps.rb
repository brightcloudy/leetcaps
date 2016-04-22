#!/usr/bin/env ruby
require 'slop'
require 'byebug'
require 'securerandom'
opts = Slop.parse suppress_errors: true do |o|
  o.banner = "usage: leetcaps [options] \"text to be leeted\""
  o.separator ""
  o.separator "Options:"
  o.string '-s', '--starts-with', 'starts with (lower, upper)', default: 'lower'
  o.bool '-r', '--random', 'swaps case at random', default: false
  o.string '-f', '--file', 'read text from file', default: nil
  o.on '--help' do
    puts o
    exit
  end
end
if opts[:file].nil? and opts.arguments.length == 0
    puts opts
    abort("Error, must pass at least one word of text to the script.")
end
if opts[:file].nil?
  toleet = opts.arguments.inject { |str, n| str + " " + n }
else
  leetfile = File.open(opts[:file])
  toleet = leetfile.readlines.inject("") { |str, line| str + line }
end
outstr = String.new()
if opts[:random] == false
  compareval = (opts[:starts_with] == 'lower') ? 0 : 1
  outstr = toleet.each_char.each_with_index.inject("") { |str, (c, idx)| str + ((idx % 2 != compareval) ? c.to_str.swapcase : c.to_str) }
else 
  outstr = toleet.each_char.each_with_index.inject("") { |str, (c, idx)| str + ((SecureRandom.random_number(2) == 0) ? c.to_str.swapcase : c.to_str) }
end
puts outstr
