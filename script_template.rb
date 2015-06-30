#!/usr/bin/env ruby
require 'optparse'
$banner  =
"Description:
------------
This script...

Usage
-----
<script> options\n\n"

# Parse command line options
def parse_options()
  options = { :value1 => 'adsf'
            }
  optparse = OptionParser.new do|opts|
    opts.banner = $banner
    opts.on( '-v', '--value1 VAL', "Value1.  Default #{options[:value1]}" ) do |value|
      options[:value1] = value
    end
    opts.on( '-h', '--help', 'Display this screen' ) do
      puts opts
      exit
    end
  end
  optparse.parse!

  if options[:value1].nil?
    raise OptionParser::MissingArgument, "value1 is a required option."
  end

  return options
rescue OptionParser::MissingArgument
  puts optparse
  raise
end


def main()
  options = parse_options()
rescue OptionParser::MissingArgument
  puts $!
end

main()
