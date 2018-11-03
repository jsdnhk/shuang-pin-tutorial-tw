COUNT = 10
TIP_ENABLE = false
SEPARATOR='~~~'

# 聲母列表 23 個 + 一個特殊的聲母 o 用來輸入單音節的韻母字
SHENG_MU = ['b', 'p', 'm', 'f', 'd', 't', 'n', 'l', 'g', 'k', 'h', 'j', 'q',
            'x', 'zh', 'ch', 'sh', 'z', 'c', 's ', ' y', 'w', 'r', 'o']
# 韻母列表 24 個
# yun_mu=['a', 'o', 'e', 'i', 'u', 'v', 'ai ', 'ei', ' ui ', 'ao', ' ou',
#         ' iu ', 'ie ', 've', ' er', ' an ', 'en ', 'in', ' un ', 'vn ', 'ang ', 'eng', ' ing ', 'ong']

# 聲母對應合法的韻母組合
LEGAL_COMPOSITE= {
    :B => %w(a ai an ang ao ei en eng i ian iao ie in ing o u),
    :C => %w(a ai an ang ao e en eng i ong ou u uan ui un uo),
    :CH => %w(a ai an ang ao e en eng i ong ou u ua uai uan uang ui un uo),
    :D => %w(a ai an ang ao e en ei eng i ia ian iao ie ing iu ong ou u uan ui un uo),
    :F => %w(a an ang ei en eng o ou u),
    :G => %w(a ai an ang ao e ei en eng ong ou u ua uai uan uang ui un uo),
    :H => %w(a ai an ang ao e ei en eng ong ou u ua uai uan uang ui un uo),
    :J => %w(i ia ian iang iao ie in ing iong iu u uan ue un),
    :K => %w(a ai an ang ao e en eng ong ou u ua uai uan uang ui un uo),
    :L => %w(a ai an ang ao e ei eng i ia ian iang iao ie in ing iu ong ou u uan ue un uo),
    :M => %w( a ai an ang ao e ei en eng i ian iao ie in ing iu o ou u),
    :N => %w(a ai an ang ao e ei en eng g i ian iang iao ie in ing iu ong ou u uan uo un),
    :P => %w(a ai an ang ao ei en eng i ian iao ie in ing o ou u),
    :Q => %w(i ia ian iang iao ie in ing iong iu u uan ue un),
    :R => %w(an ang ao e en eng i ong ou u uan ui un uo),
    :S => %w(a ai an ang ao e en eng i ong ou u uan ui un uo),
    :SH => %w(a ai an ang ao e ei en eng i ou u ua uai uan uang ui un uo),
    :T => %w(a ai an ang ao e eng i ian iao ie ing ong ou u uan ui un uo),
    :W => %w(a ai an ang ei en eng o u),
    :X => %w(i ia ian iang iao ie in ing iong iu u uan ue un),
    :Y => %w(a an ang ao e i in ing o ong ou u uan ue un),
    :Z => %w(a ai an ang ao e ei en eng i ong ou u uan ui un uo),
    :ZH => %w(a ai an ang ao e ei en eng i ong ou u ua uai uan uang ui un uo),
    :O => %w(a o e an ao ai ei en eng er ang ou)
}


# 每個按鍵對應的雙拼表
VALID_COMPOSITE={
    :Q => %w(q iu),
    :W => %w(w ia ua),
    :E => %w(e),
    :R => %w(r uan er),
    :T => %w(t ue),
    :Y => %w(y uai v),
    :U => %w(u sh),
    :I => %w(i ch),
    :O => %w(o uo),
    :P => %w(p un),
    :A => %w(a),
    :S => %w(s ong iong),
    :D => %w(d uang iang),
    :F => %w(f en),
    :G => %w(g eng),
    :H => %w(h ang),
    :J => %w(j an),
    :K => %w(k ao),
    :L => %w(l ai),
    ';' => %w(ing),
    :Z => %w(z ei),
    :X => %w(x ie),
    :C => %w(c iao),
    :V => %w(zh ve ui),
    :B => %w(b ou),
    :N => %w(n in),
    :M => %w(m ian),
}


def rand_words(num = COUNT)
  result = ''
  num.times do
    sheng =SHENG_MU.sample
    yun = LEGAL_COMPOSITE[sheng.strip.upcase.to_sym].sample
    if sheng =='o'
      result<<"#{yun.strip} "
    else
      result<<"#{sheng.strip}#{yun.strip} "
    end
  end
  result
end


puts "請輸入下面對應雙拼規則 使用空格隔開, 退出輸入 exit \n"


def judge(incorrect, input_answer, result)
  if incorrect.length == 0
    puts '恭喜你全對耶!'
  else
    incorrect.each { |key, value|
      puts "#{key} 錯誤 => #{value}"
    }
  end

  if input_answer.split.length < result.split(SEPARATOR)[0].split.length
    puts '你好像有幾個沒有寫完哦!'
  end
end

def get(word, right)
  VALID_COMPOSITE.each { |key, value|
    if value.include? word
      right<<key.to_s
      break
    end
  }
end

def get_right_answer(res)
  right=''
  if LEGAL_COMPOSITE[:O].include? res
    # 說明是韻母單音節字
    right<<'O'
    get(res, right)
    return right
  end


  d_pre = res.strip[0..1]
  if %w(zh ch sh).include? d_pre
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
  result =rand_words
  if TIP_ENABLE
    result << "   #{SEPARATOR}   ( "
    result.split.each { |res|
      an = get_right_answer(res)
      result << "#{an} "
    }
    result << ' ) '
  end
  result
end

# main
while true
  result = question
  puts "\n#{result}"

  input_answers = gets

  if input_answers.strip == 'exit'
    abort('好棒好棒!')
  end
  # 隨機組合
  # 錯誤的字
  incorrect ={}

  input_answers.split.each_with_index { |input_keys, index|

    if input_keys.length!=2
      incorrect["#{index+1}.#{input_keys}"] = '雙拼只能由兩個字母組合而成!'
      next
    end

    res = result.split[index]
    right_answer= get_right_answer(res)
    unless right_answer.casecmp(input_keys.to_s)==0
      incorrect["#{index+1}.#{input_keys}"] = "不能得到 #{res} 哦! 或許你可以試試 #{right_answer}"
    end
  }
  judge(incorrect, input_answers, result)

end

