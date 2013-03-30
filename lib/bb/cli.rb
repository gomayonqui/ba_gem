require 'thor'
require 'yaml'
require 'mechanize'
require 'highline/import'
require 'bb/banks'

module Bb
  class CLI < Thor
    include Banks

    # Add the banks located in the bb/banks directory to the command line menu
    Bb::Banks.constants.each do |bank|
      bank_class = Bb::Banks.const_get(bank)
      sub_command = bank.downcase
      register(bank_class, sub_command, "#{sub_command} [COMMAND]", "#{bank} Bank usage.")
    end

    desc "install", "Create the basic config file for the application to work"
    def install
      unless config_exists?
        puts "[INFO] A config folder will be created in your home path '~/config'"
        puts "[INFO] Please run the 'bank_balance' from your home path so you can keep the config file save"

        create_config_file_for_banks
      end

      puts "[INFO] Please edit your ~/config/config.yml"
    end

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
      puts `mkdir #{home_path}`
      puts `cp #{config_path}/config.sample.yml #{home_path}/config.yml`
    end
  end
end
