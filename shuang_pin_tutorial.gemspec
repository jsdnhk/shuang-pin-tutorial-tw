# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "shuang_pin_tutorial"

Gem::Specification.new do |s|
  s.name        = ShuangPinTutorial::NAME
  s.version     = ShuangPinTutorial::VERSION
  s.licenses    = 'MIT'
  s.summary     = "A tutorial application for Microsoft Shuang Pin input method(zh-tw)."
  s.description = "An interesting, featured tutorial application for practicing Microsoft Shuang Pin input method(zh-tw)."
  s.homepage    = 'http://jsdn.hk/shuang_pin_tutorial/'
  s.authors     = ["David N"]
  s.email       = 'dn@jsdn.hk'

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
      "changelog_uri"     => "https://github.com/jsdnhk/shuang_pin_tutorial/blob/master/CHANGELOG.md",
      "documentation_uri" => "https://github.com/jsdnhk/shuang_pin_tutorial/blob/master/README.md"
  }

  s.add_runtime_dependency("mercenary", "~> 0.4.0")
  # s.add_runtime_dependency("i18n", "~> 1.2.0")
end
