require 'thor'
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

    desc "version", "Returns the Application version"
    def version
      puts Ba::VERSION
    end

    map "-v" => :version
  end
end
