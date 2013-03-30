require 'thor'
require 'yaml'
require 'mechanize'
require 'highline/import'
require 'ba/banks'

module Ba
  class CLI < Thor
    include Banks

    # Add the banks located in the ba/banks directory to the command line menu
    Ba::Banks.constants.each do |bank|
      bank_class = Ba::Banks.const_get(bank)
      sub_command = bank.downcase
      register(bank_class, sub_command, "#{sub_command} [COMMAND]", "#{bank} Bank usage.")
    end

    desc "install", "Create the basic config file for the application to work"
    def install
      if config_exists?
        puts "configuration file already exists"
      else
        create_config_file_for_banks
      end
    end

    map "-i" => :install

    desc "version", "Returns the Application version"
    def version
      puts Ba::VERSION
    end

    map "-v" => :version

    private

    def config_exists?
      begin
        File.open("config/config.yml")
      rescue Errno::ENOENT
        false
      end
    end

    def create_config_file_for_banks
      config_path = File.join(File.dirname(__FILE__),"../../", "config")
      home_path = "~/config"
      system "mkdir #{home_path}"
      system "cp #{config_path}/config.sample.yml #{home_path}/config.yml"
      puts "[INFO] A config folder will be created in your home path '~/config'\n\n"\
      "[INFO] Please edit your ~/config/config.yml"
    end
  end
end
