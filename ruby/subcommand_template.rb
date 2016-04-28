#!/usr/bin/ruby

require 'optparse'

$banners  = {
  :main => "\
This thing has multiple subcommands.  You have to use one of them.  They are
listed below.

Use the -h option with each of the subcommands for more information.

Usage: sub_command_optparse.rb [options] [subcommand [options]]
--------
",
  :asdf => "\
This is the asdf help
",
  :wasd => "\
This is the wasd help
"
}

def parse_options()
  options = {
    :command => '',
    :verbose => false,
    :all => false,
    :move_keys => 'wasd'
  }

  subcommands = {
    'asdf' => OptionParser.new do |opts|
      opts.banner = $banners[:asdf]
      opts.on('-a', '--all', 'All the asdf you want.') do |x|
        options[:all] = x
      end
    end,

    'wasd' => OptionParser.new do |opts|
      opts.banner = $banners[:wasd]
      opts.on('-u', '--use_other OPT', 'Supply another 4 keys for movement') do |x|
        options[:move_keys] = x
      end
    end
  }

  global_banner = $banners[:main] +
                   " * " + subcommands.keys.join("\n * ") +
                   "\n\n## Options"

  global = OptionParser.new do |opts|
    opts.banner = global_banner
    opts.on('-v', '--verbose', 'Obiligatory verbose option.') do |g|
      options[:verbose] = g
    end
  end

  global.order!
  # print message if a subcommand was not supplied
  if(ARGV.size == 0)
    print "This command requires one of the following subcommands.  " +
         "Use -h option for more information.\n  "
    puts subcommands.keys.join("\n  ")
    exit
  else
    command = ARGV.shift
    subcommands[command].order!
    options[:command] = command
  end

  return options
end


def main()
  begin
    options = parse_options
    if(options[:verbose])
      puts "The options:  \n#{options}"
    end

    case options[:command]
    when 'asdf'
      puts 'This does Absolutely nothing!!'
    when 'wasd'
      puts 'Movement keys!!'
    end
  rescue OptionParser::MissingArgument => e
    puts "SUPPLY ALL ARGUMENTS!"
  rescue OptionParser::InvalidOption => e
    puts "You've supplied an #{e.to_s}"
  end
end

main()
