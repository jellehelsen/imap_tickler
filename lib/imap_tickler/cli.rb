require 'optparse'
require "yaml"
require "imap_tickler/tickler"
module ImapTickler
  class CLI
    def self.execute(input,output,arguments=[])
      options = {:config_file => "~/.imap_tickler.conf"}
      parser = OptionParser.new do |opts|
        opts.banner = <<-BANNER.gsub(/^          /,'')
            Usage: #{File.basename($0)} [options]

            Options are:
        BANNER
        opts.on( "-F path", "", String,
                "Load an alternate config file") do |opt|
          options[:config_file] = opt
                end
      end
      parser.parse(arguments)
      config = YAML.load_file(File.expand_path(options[:config_file]))
      Tickler.new(config).start
    end
  end
end
