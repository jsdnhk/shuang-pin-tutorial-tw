# frozen_string_literal: true

require "rubygems"
require 'rake'
require 'yaml'
require 'time'

require "bundler/gem_tasks"
require "rspec/core/rake_task"

SOURCE = "."
DIRS = {
    'lib' => File.join(SOURCE, "lib"),
    'scripts' => File.join(SOURCE, "scripts"),
}

def ask(message, valid_options)
  if valid_options
    answer = get_stdin("#{message}-->#{valid_options.to_s.gsub(/"/, '').gsub(/, /,'/')} ") while !valid_options.include?(answer)
  else
    answer = get_stdin(message)
  end
  answer
end

def get_stdin(message)
  print message
  STDIN.gets.chomp
end

# import default rake tasks from rspec
RSpec::Core::RakeTask.new(:spec)

desc "Perform Ruby programming syntax recommendation"
task :syncheck do
  system 'bundle exec rubocop -D -S'
end

desc "Push the current code to the master branch"
task :cmpush do
  abort("rake aborted!") unless ask("Sure to commit all the change to remote?", %w(y n)) == 'y'
  system "./git-commit-push.sh", chdir: DIRS['scripts']
end

desc "Push the current code to the master branch"
task :verpush do
  abort("rake aborted!") unless ask("Sure to push the new version to remote?", %w(y n)) == 'y'
  system "./git-version-push.sh", chdir: DIRS['scripts']
end