#!/usr/bin/ruby
# encoding: UTF-8

require_relative 'handler'

module ShuangPinTutorial
  class Main
    def initialize()
      @is_run_success = true
      @obj_tutorial = nil
    end

    def run()
      @obj_tutorial = Handler.new()
      @obj_tutorial.start()
    rescue Interrupt => ir
      $stdout.puts('累了就該休息一下吧！')
    rescue Exception => ex
      $stderr.puts('執行時發生錯誤哦，信息在下面：')
      $stderr.puts(ex.message)
      $stderr.puts(ex.backtrace)
      @is_run_success = false
    ensure
      $stdout.puts('訓練時間：')
      $stdout.puts(@obj_tutorial.get_total_time_str)
      $stdout.puts('成果統計：')
      $stdout.puts(@obj_tutorial.get_total_words_result)
      $stdout.puts('要努力學習哦，感謝使用！')
      exit(@is_run_success)
    end
  end
end

if __FILE__ == $0  # for test-run use
  main = ShuangPinTutorial::Main.new()
  main.run()
end