#!/usr/bin/env ruby
require 'optparse'
$banner  ="\
Description:
------------
This script...

Usage
-----
<script> [options]\n\n"


# Parse command line options
def parse_options()
  options = { :verbose => false }

  optparse = OptionParser.new do|opts|
    opts.banner = $banner
    opts.on( '-v', '--verbose', "Verbose output" ) do |value|
      options[:verbose] = value
    end
    opts.on( '-h', '--help', 'Display this screen' ) do
      puts opts
      exit
    end
  end
  optparse.parse!

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
