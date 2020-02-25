# frozen_string_literal: true

# $LOAD_PATH.unshift __dir__ # For use/testing when no gem is installed

# Require all of the Ruby files in the given directory.
def require_all(path)
  glob = File.join(__dir__, path, "*.rb")
  Dir[glob].sort.each do |f|
    require f
  end
end

module ShuangPinTutorial
  MODULE = "ShuangPinTutorial"
  NAME = "shuang_pin_tutorial"
  VERSION = "1.1.0"

  autoload(:Main, "#{NAME}/main")
  autoload(:Handler, "#{NAME}/handler")
  autoload(:Data, "#{NAME}/data")
end