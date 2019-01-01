#!/usr/bin/ruby
#
# encoding: UTF-8

require_relative "shuang_pin_data"

COUNT = 6
SEPARATOR='———'
IS_ENABLE_TIPS = true
IS_DISPLAY_ZHUYIN = true
IS_DISPLAY_WORD = true

def get_words_showlines(num = COUNT, display_delim: "|")   # return [words(str), [display line(s)]]
  result = []
  display = []
  display_py = []
  display_zy = []
  display_cw = []
  num.times do
    sheng, yun = ShuangPinData::get_rand_sheng_yun_sym()
    shengyun = ShuangPinData::get_sy(sheng, yun)
    zy = ShuangPinData::get_zy(sheng, yun)
    cw = ShuangPinData::get_cw(sheng, yun)
    result.push(shengyun)
    display_py.push(shengyun + "\t")
    display_zy.push(zy + "\t")
    display_cw.push(cw + "\t")
  end
  display << display_py.join(display_delim)
  display << display_zy.join(display_delim) if IS_DISPLAY_ZHUYIN
  display << display_cw.join(display_delim) if IS_DISPLAY_WORD
  [result.join(" "), display]
end

def judge(incorrect, input_answer, result_words)
  if input_answer.split.length == result_words.split.length && incorrect.length == 0
    puts '恭喜你全對耶！'
  else
    incorrect.each { |key, value|
      puts "#{key} 錯誤 => #{value}"
    }
  end

  if input_answer.split.length < result_words.split.length
    puts "你好像有幾個沒有寫完哦！共有：#{result_words.split.length}，已輸入：#{input_answer.split.length}"
  end
end

def get(word, right)
  ShuangPinData::VALID_COMPOSITE.each { |key, value|
    if value.include?(word)
      right << key.to_s
      break
    end
  }
end

def get_right_answer(res)
  right=''
  if ShuangPinData::LEGAL_COMPOSITE[:o].include?(res)
    # 說明是韻母單音節字
    right << 'O'
    get(res, right)
    return right
  end

  d_pre = res.strip[0..1]

  if %w(zh ch sh).include?(d_pre)
    get(d_pre, right)
    d_next = res.strip[2...res.length]
    get(d_next, right)
  else
    d_pre = res.strip[0]
    get(d_pre, right)
    d_next = res.strip[1...res.length]
    get(d_next, right)
  end

  right
end

def question
  result = get_words_showlines
  result_words = result[0]
  result_display = result[1]
  result_tips = []
  if IS_ENABLE_TIPS
    result_words.split.each { |res|
      result_tips.push(get_right_answer(res))
    }
    result_display[0] = "#{result_display[0]}  #{SEPARATOR}  【#{result_tips.join(" ")}】"
  end
  result
end

# main
def main()
  # initialization
  sp_data = ShuangPinData.new()

  puts "歡迎使用 快速學習雙拼 -- 微軟雙拼（繁體中文版）"
  puts "請輸入下面對應雙拼規則。使用空格隔開，退出輸入 exit \n"
  # looping
  while true
    result = question
    result_words = result[0]
    result_display = result[1]
    print "\n#{result_display.join("\n")}\n"

    input_answers = gets

    abort('努力學習！感謝使用！') if input_answers.strip == 'exit'

    # 隨機組合
    # 錯誤的字
    incorrect = {}

    input_answers.split.each_with_index { |input_keys, index|

      if input_keys.length != 2
        incorrect["#{index + 1}.#{input_keys}"] = '雙拼只能由兩個字母組合而成！'
        next
      end

      res = result_words.split[index]
      right_answer = get_right_answer(res)
      unless right_answer.casecmp(input_keys.to_s) == 0
        incorrect["#{index+1}.#{input_keys}"] = "不能得到 #{res} 哦！或許你可以試試 #{right_answer}"
      end
    }
    judge(incorrect, input_answers, result_words)
  end
end

main()