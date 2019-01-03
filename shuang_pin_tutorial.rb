#!/usr/bin/ruby
#
# encoding: UTF-8

require_relative "shuang_pin_data"

INT_WORDS_DISPLAYED = 6
STR_TIPS_SEPARATOR='———'
IS_ENABLE_TIPS = true
IS_DISPLAY_ZHUYIN = true
IS_DISPLAY_CWORD = true

class ShuangPinTutorial
  # 控制方法
  def start()
    # 初始化
    @sp_data = ShuangPinData.new()

    puts "歡迎使用 快速學習雙拼 -- 微軟雙拼（繁體中文版）！要好好練習哦！"
    puts "請您輸入下面中文字對應雙拼字碼。使用空格隔開，要退出請輸入'exit'。\n"
    # looping
    while true
      result = get_question_lines
      result_words = result[0]
      result_display = result[1]
      print "\n#{result_display.join("\n")}\n"

      input_answers = gets

      if input_answers.respond_to?(:to_str)
        break if input_answers.strip.downcase == 'exit'
        eval_result(input_answers, result_words)
      end
    end
  end

  def get_words_showlines(num = INT_WORDS_DISPLAYED, display_delim: "|")   # return [words(str), [display line(s)]]
    result = []
    display = []
    display_py = []
    display_zy = []
    display_cw = []
    num.times do
      sheng, yun = @sp_data.get_rand_sheng_yun_sym()
      shengyun = @sp_data.get_sy(sheng, yun)
      zy = @sp_data.get_zy(sheng, yun)
      cw = @sp_data.get_cw(sheng, yun)
      result.push(shengyun)
      display_py.push(shengyun + "\t")
      display_zy.push(zy + "\t")
      display_cw.push(cw + "\t")
    end
    display << display_py.join(display_delim)
    display << display_zy.join(display_delim) if IS_DISPLAY_ZHUYIN
    display << display_cw.join(display_delim) if IS_DISPLAY_CWORD
    [result.join(" "), display]
  end

  def eval_result(input_answer, result_words)
    # 尋找打錯了的字
    incorrect = {}
    input_answer.split.each_with_index do |input_keys, index|
      if input_keys.length != 2
        incorrect[index + 1] = "#{input_keys}： 雙拼只能由兩個字母組合而成！"
        next
      end

      res = result_words.split[index]
      right_answer = @sp_data.get_correct_keys(res)
      unless right_answer.casecmp(input_keys.to_s) == 0
        incorrect[index + 1] = "#{input_keys}： 不能得到 #{res} 哦！或許你可以試試 #{right_answer}"
      end
    end

    # 編出成績
    is_all_finished = input_answer.split.length == result_words.split.length
    if !is_all_finished
      puts "你好像寫不齊哦！共有：#{result_words.split.length}，已輸入：#{input_answer.split.length}"
    else
      if incorrect.length == 0
        puts '恭喜你全對耶！'
      end
    end
    incorrect.each { |key, value| puts "#{key}) 錯誤 => #{value}"}
  end

  def get_question_lines
    result = get_words_showlines
    result_words = result[0]
    result_display = result[1]
    result_tips = []
    if IS_ENABLE_TIPS
      result_words.split.each { |res| result_tips.push(@sp_data.get_correct_keys(res)) }
      result_display[0] = "#{result_display[0]}  #{STR_TIPS_SEPARATOR}  【#{result_tips.join(" ")}】"
    end
    result
  end
end

if __FILE__ == $0
  is_run_success = true
  begin
    obj_tutorial = ShuangPinTutorial.new()
    obj_tutorial.start()
  rescue Interrupt => ir
    $stdout.puts('累了就該休息一下吧！')
  rescue Exception => ex
    $stderr.puts('執行時發生錯誤哦，信息在下面：')
    $stderr.puts(ex.message)
    $stderr.puts(ex.backtrace)
    is_run_success = false
  ensure
    $stdout.puts('要努力學習哦，感謝使用呀！')
    exit(is_run_success)
  end
end