# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "shuang_pin_tutorial"

Gem::Specification.new do |s|
  s.name        = ShuangPinTutorial::NAME
  s.version     = ShuangPinTutorial::VERSION
  s.licenses    = 'MIT'
  s.summary     = "The tutorial application for Microsoft Shuang Pin input method"
  s.description = "Traditional Chinese version with zhuyin, pinyin and example word display"
  s.authors     = ["David N"]
  s.email       = 'dn@jsdn.hk'
  s.homepage    = 'https://jsdn.hk'

  s.post_install_message = "Welcome using Microsoft Shuang Pin tutorial!"

  s.rdoc_options     = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w(README.md LICENSE)

  all_files       = `git ls-files -z`.split("\x0")
  s.files         = all_files.grep(%r!^(exe|lib|rubocop)/|^.rubocop.yml$!)
  s.executables   = all_files.grep(%r!^exe/!) { |f| File.basename(f) }
  s.bindir        = "exe"
  s.require_paths = ["lib"]

  s.required_ruby_version     = ">= 2.4.0"
  s.required_rubygems_version = ">= 2.7.0"

  s.metadata = {
      "source_code_uri" => "https://github.com/jsdnhk/shuang_pin_tutorial",
      "changelog_uri"     => "https://github.com/jsdnhk/shuang_pin_tutorial/CHANGELOG.md",
      "documentation_uri" => "https://github.com/jsdnhk/shuang_pin_tutorial/README.md"
  }
end
