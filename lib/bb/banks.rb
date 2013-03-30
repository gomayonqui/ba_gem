# LOAD THE BANKS
Dir[File.join("#{File.dirname(__FILE__)}/banks/**.rb")].each { |f| require f }
