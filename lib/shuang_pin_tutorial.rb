#!/usr/bin/ruby
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
  VERSION = "1.3.0"
  OPTIONS = {w: "words", r: "remind_off", z: "zhuyin_off", c: "cword_off"}
  OPTIONS_DEFAULT = {w: 6, r: true, z: true, c: true}

  autoload(:Main, "#{NAME}/main")
  autoload(:Handler, "#{NAME}/handler")
  autoload(:Data, "#{NAME}/data")
end

if __FILE__ == $0  # for test-run use
  main = ShuangPinTutorial::Main.new()
  main.run()
end