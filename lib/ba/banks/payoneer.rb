module Ba::Banks
  class Payoneer < Thor

    desc "balance", "Returns the Payoneer account balance"
    def balance
      puts "Not yet Implemented"
    end

    private

    def config
      @config ||= YAML::load(File.open('config/config.yml'))["payoneer"]
    end
  end
end
