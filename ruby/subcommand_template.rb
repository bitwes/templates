#!/usr/bin/ruby

require 'optparse'

$subtext  ="\
This thing has multiple subcommands.  They are:

asdf           The standard in non-functional options.  The asdf option features
               easy to type characters and a complete lack of any meaning.
wasd           The keys to use for movement.

Use the -h option with each of the subcommands for more information.  The following
options are valid for any subcommand:

Usage: sub_command_optparse.rb [options] [subcommand [options]]
--------
"

def parse_options()
  options = {
    :command => '',
    :verbose => false,
    :all => false,
    :move_keys => 'wasd'
  }

  global = OptionParser.new do |opts|
    opts.banner = $subtext
    opts.on('-v', '--verbose', 'Obiligatory verbose option.') do |g|
      options[:verbose] = g
    end
  end


  subcommands = {
    'asdf' => OptionParser.new do |opts|
      opts.banner = "Look!! another 'asdf' thing."
      opts.on('-a', '--all', 'All the asdf you want.') do |x|
        options[:all] = x
      end
    end,

    'wasd' => OptionParser.new do |opts|
      opts.banner = 'Your movement keys'
      opts.on('-u', '--use_other OPT', 'Supply another 4 keys for movement') do |x|
        options[:move_keys] = x
      end
    end
  }

  global.order!
  command = ARGV.shift
  subcommands[command].order!

  options[:command] = command
  return options
end


def main()
  options = parse_options
  if(options[:verbose])
    puts "The options:  \n#{options}"
  end

  case options[:command]
  when 'asdf'
    puts 'Absolutely nothing!!'
  when 'wasd'
    puts 'Movement keys!!'
  end
end

main()
