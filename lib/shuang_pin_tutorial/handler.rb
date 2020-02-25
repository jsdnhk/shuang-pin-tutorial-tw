# encoding: UTF-8

require 'date'
require_relative 'data'

module ShuangPinTutorial
  INT_WORDS_DISPLAYED = 6
  STR_TIPS_SEPARATOR='———'
  IS_ENABLE_TIPS = true
  IS_DISPLAY_ZHUYIN = true
  IS_DISPLAY_CWORD = true

  class Handler
    def initialize()
    end

    def start()
      # 初始化
      @sp_data = Data.new()
      @words_counts = [0, 0, 0]
      @start_time = DateTime.now
      @end_time = nil
      puts "歡迎使用 快速學習雙拼 -- 微軟雙拼（繁體中文版）！要好好練習哦！（#{VERSION} 版）"
      puts "要輸入下面中文字對應雙拼字碼哦！使用空格隔開，要休息請輸入 'exit' 或按 Ctrl+c 吧！\n"
      # looping
      while true
        result = get_question_lines
        result_words = result[0]
        result_display = result[1]
        print "\n#{result_display.join("\n")}\n"

        input_answers = gets

        if input_answers.respond_to?(:to_str)
          raise(Interrupt, "用戶退出") if input_answers.strip.downcase == 'exit'
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
      correct = 0
      is_all_finished = input_answer.split.length >= result_words.split.length
      input_answer.split.each_with_index do |input_keys, index|
        break if index >= result_words.split.length   # ignore the extra input part

        if input_keys.length != 2
          incorrect[index + 1] = "#{input_keys}： 雙拼只能由兩個字母組合而成！"
          next
        end

        res = result_words.split[index]
        right_answer = @sp_data.get_correct_keys(res)
        unless right_answer.casecmp(input_keys.to_s) == 0
          incorrect[index + 1] = "#{input_keys}： 不能得到 #{res} 哦！或許你可以試試 #{right_answer}"
        else
          correct += 1
        end
      end

      # 編出成績
      @words_counts[0] += result_words.split.length
      @words_counts[1] += correct
      @words_counts[2] += result_words.split.length - correct

      if !is_all_finished
        puts "你好像寫不齊哦！共有：#{result_words.split.length}，已輸入：#{input_answer.split.length}"
      elsif incorrect.length == 0
        puts '恭喜你全對耶！'
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

    def get_total_time_str
      @end_time = DateTime.now
      @total_time = ((@end_time - @start_time) * 24 * 60 * 60).to_i
      str_total_time_s = Time.at(@total_time).utc.strftime("%S").gsub(/^0/, '')
      str_total_time_m = Time.at(@total_time).utc.strftime("%M").gsub(/^0/, '')
      str_total_time_h = Time.at(@total_time).utc.strftime("%H").gsub(/^0+/, '')
      str_total_time =
      case @total_time
        when 0...60
          "#{str_total_time_s} 秒"
        when 60...3600
          "#{str_total_time_m} 分 #{str_total_time_s} 秒"
        else
          "#{str_total_time_h} 小時 #{str_total_time_m} 分 #{str_total_time_s} 秒"
      end
      str_total_time
    end

    def get_total_words_result
      percent_correctness = @words_counts[0].to_f != 0 ? (@words_counts[1].to_f/@words_counts[0].to_f) * 100 : 0
      str_output = ""
      str_output += "共有字數： #{@words_counts[0]} 字；正確字數： #{@words_counts[1]} 字；錯誤字數： #{@words_counts[2]} 字" + "\n"
      str_output += "總正確率： #{percent_correctness.round(2)} %"
      str_output
    end
  end
end