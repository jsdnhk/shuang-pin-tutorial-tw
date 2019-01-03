# encoding: UTF-8

class ShuangPinData
  # 聲母列表 23 個 + 一個特殊的聲母 o 用來輸入單音節的韻母字
  SHENG_MU = {
      b: "ㄅ", p: "ㄆ", m: "ㄇ", f: "ㄈ",
      d: "ㄉ", t: "ㄊ", n: "ㄋ", l: "ㄌ",
      g: "ㄍ", k: "ㄎ", h: "ㄏ",
      j: "ㄐ", q: "ㄑ", x: "ㄒ",
      zh: "ㄓ", ch: "ㄔ", sh: "ㄕ", r: "ㄖ",
      z: "ㄗ", c: "ㄘ", s: "ㄙ",
      y: "ㄧ", w: "ㄨ", o: ""
  }

  # 韻母列表 35 個
  YUN_MU = {
      # 開口呼
      a: "ㄚ", o: "ㄛ", e: "ㄜ", er: "ㄦ",
      ai: "ㄞ", ei: "ㄟ", ao: "ㄠ", ou: "ㄡ",
      an: "ㄢ", en: "ㄣ", ang: "ㄤ", eng: "ㄥ",
      # 齊齒呼
      i: "ㄧ", ia: "ㄧㄚ", ie: "ㄧㄝ", iao: "ㄧㄠ",
      iu: "ㄧㄡ", ian: "ㄧㄢ", in: "ㄧㄣ", iang: "ㄧㄤ",
      ing: "ㄧㄥ",
      # 合口呼
      u: "ㄨ", ua: "ㄨㄚ", uo: "ㄨㄛ", uai: "ㄨㄞ",
      ui: "ㄨㄟ", uan: "ㄨㄢ", un: "ㄨㄣ", uang: "ㄨㄤ",
      ong: "ㄨㄥ",
      # 撮口呼
      ü: "ㄩ", üe: "ㄩㄝ", üan: "ㄩㄢ", ün: "ㄩㄣ",
      iong: "ㄩㄥ"
  }

=begin
'y' and 'w' is not included because 'ㄧ' and 'ㄨ' are already
mapped to 'i' and 'u'
"ㄧ": "y", "ㄨ": "w",
=end

  # 聲母對應合法的韻母組合
  LEGAL_COMPOSITE = {
      :b => %w(a ai an ang ao ei en eng i ian iao ie in ing o u),
      :p => %w(a ai an ang ao ei en eng i ian iao ie in ing o ou u),
      :m => %w(a ai an ang ao e ei en eng i ian iao ie in ing iu o ou u),
      :f => %w(a an ang ei en eng o ou u),
      :d => %w(a ai an ang ao e ei eng i ian iao ie ing iu ong ou u uan ui un uo),
      :t => %w(a ai an ang ao e eng i ian iao ie ing ong ou u uan ui un uo),
      :n => %w(a ai an ang ao e ei en eng i ian iang iao ie in ing iu ong u uan uo ü üe),
      :l => %w(a ai an ang ao e ei eng i ia ian iang iao ie in ing iu ong ou u uan un uo ü üe),
      :g => %w(a ai an ang ao e ei en eng ong ou u ua uai uan uang ui un uo),
      :k => %w(a ai an ang ao e en eng ong ou u ua uai uan uang ui un uo),
      :h => %w(a ai an ang ao e ei en eng ong ou u ua uai uan uang ui un uo),
      :j => %w(i ia ian iang iao ie in ing iu u üe üan ün iong),    # ü as u
      :q => %w(i ia ian iang iao ie in ing iu u üe üan ün iong),    # ü as u
      :x => %w(i ia ian iang iao ie in ing iu u üe üan ün iong),    # ü as u
      :zh => %w(a ai an ang ao e ei en eng i ong ou u ua uai uan uang ui un uo),
      :ch => %w(a ai an ang ao e en eng i ong ou u uai uan uang ui un uo),
      :sh => %w(a ai an ang ao e ei en eng i ou u ua uai uan uang ui un uo),
      :r => %w(an ang ao e en eng i ong ou u uan ui un uo),
      :z => %w(a ai an ang ao e ei en eng i ong ou u uan ui un uo),
      :c => %w(a ai an ang ao e en eng i ong ou u uan ui un uo),
      :s => %w(a ai an ang ao e en eng i ong ou u uan ui un uo),
      :y => %w(a an ang ao e i in ing ong ou u üan üe ün),  # ü as u
      :w => %w(a ai an ang ei en eng o u),
      :o => %w(a o e an ao ai ei en eng er ang ou)
  }

  # 普通話聲韻配合表
  SHENG_YUN_WORD_TABLE = {
      :b => {:a=>"巴", :o=>"玻", :ai=>"白", :ei=>"杯", :ao=>"包", :an=>"般", :en=>"奔", :ang=>"幫", :eng=>"崩", :i=>"逼", :ie=>"別", :iao=>"標", :ian=>"邊", :in=>"濱", :ing=>"冰", :u=>"不"},
      :p => {:a=>"趴", :o=>"坡", :ai=>"拍", :ei=>"培", :ao=>"拋", :ou=>"剖", :an=>"潘", :en=>"噴", :ang=>"旁", :eng=>"烹", :i=>"批", :ie=>"撇", :iao=>"飄", :ian=>"篇", :in=>"拼", :ing=>"乒", :u=>"鋪"},
      :m => {:a=>"媽", :o=>"摸", :e=>"麼", :ai=>"埋", :ei=>"眉", :ao=>"貓", :ou=>"謀", :an=>"蠻", :en=>"悶", :ang=>"忙", :eng=>"盟", :i=>"迷", :ie=>"滅", :iao=>"苗", :iu=>"謬", :ian=>"棉", :in=>"民", :ing=>"明", :u=>"木"},
      :f => {:a=>"發", :o=>"佛", :ei=>"飛", :ou=>"否", :an=>"翻", :en=>"分", :ang=>"方", :eng=>"風", :u=>"夫"},
      :d => {:a=>"搭", :e=>"得", :ai=>"呆", :ei=>"得", :ao=>"刀", :ou=>"兜", :an=>"單", :ang=>"當", :eng=>"登", :i=>"低", :ie=>"爹", :iao=>"雕", :iu=>"丟", :ian=>"顛", :ing=>"㆜", :u=>"都", :uo=>"多", :ui=>"堆", :uan=>"端", :un=>"蹲", :ong=>"東"},
      :t => {:a=>"他", :e=>"特", :ai=>"胎", :ao=>"滔", :ou=>"偷", :an=>"攤", :ang=>"湯", :eng=>"疼", :i=>"梯", :ie=>"貼", :iao=>"挑", :ian=>"㆝", :ing=>"聽", :u=>"禿", :uo=>"脫", :ui=>"推", :uan=>"團", :un=>"吞", :ong=>"通"},
      :n => {:a=>"拿", :e=>"訥", :ai=>"奶", :ei=>"內", :ao=>"腦", :an=>"南", :en=>"嫩", :ang=>"囊", :eng=>"能", :i=>"泥", :ie=>"捏", :iao=>"鳥", :iu=>"牛", :ian=>"年", :in=>"您", :iang=>"娘", :ing=>"寧", :u=>"奴", :uo=>"挪", :uan=>"暖", :ong=>"農", :ü=>"女", :üe=>"虐"},
      :l => {:a=>"拉", :e=>"勒", :ai=>"來", :ei=>"累", :ao=>"老", :ou=>"樓", :an=>"蘭", :ang=>"郎", :eng=>"冷", :i=>"黎", :ia=>"倆", :ie=>"列", :iao=>"了", :iu=>"流", :ian=>"連", :in=>"林", :iang=>"涼", :ing=>"零", :u=>"爐", :uo=>"鑼", :uan=>"亂", :un=>"輪", :ong=>"龍", :ü=>"呂", :üe=>"略"},
      :g => {:a=>"嘎", :e=>"哥", :ai=>"該", :ei=>"給", :ao=>"高", :ou=>"溝", :an=>"甘", :en=>"根", :ang=>"剛", :eng=>"更", :u=>"姑", :ua=>"瓜", :uo=>"鍋", :uai=>"拐", :ui=>"規", :uan=>"關", :un=>"滾", :uang=>"光", :ong=>"工"},
      :k => {:a=>"咖", :e=>"科", :ai=>"開", :ao=>"考", :ou=>"口", :an=>"刊", :en=>"肯", :ang=>"康", :eng=>"坑", :u=>"枯", :ua=>"誇", :uo=>"闊", :uai=>"快", :ui=>"虧", :uan=>"寬", :un=>"昆", :uang=>"筐", :ong=>"空"},
      :h => {:a=>"哈", :e=>"喝", :ai=>"海", :ei=>"黑", :ao=>"好", :ou=>"後", :an=>"寒", :en=>"很", :ang=>"杭", :eng=>"哼", :u=>"呼", :ua=>"花", :uo=>"火", :uai=>"懷", :ui=>"灰", :uan=>"歡", :un=>"婚", :uang=>"荒", :ong=>"轟"},
      :j => {:i=>"基", :ia=>"家", :ie=>"街", :iao=>"交", :iu=>"究", :ian=>"堅", :in=>"今", :iang=>"江", :ing=>"京", :u=>"居", :üe=>"決", :üan=>"捐", :ün=>"軍", :iong=>"窘"},
      :q => {:i=>"欺", :ia=>"搯", :ie=>"切", :iao=>"敲", :iu=>"秋", :ian=>"千", :in=>"親", :iang=>"腔", :ing=>"清", :u=>"區", :üe=>"缺", :üan=>"圈", :ün=>"群", :iong=>"窮"},
      :x => {:i=>"希", :ia=>"瞎", :ie=>"些", :iao=>"消", :iu=>"休", :ian=>"先", :in=>"新", :iang=>"香", :ing=>"星", :u=>"虛", :üe=>"靴", :üan=>"宣", :ün=>"詢", :iong=>"兄"},
      :zh => {:a=>"渣", :e=>"遮", :i=>"知", :ai=>"窄", :ei=>"這", :ao=>"招", :ou=>"周", :an=>"沾", :en=>"真", :ang=>"張", :eng=>"爭", :u=>"珠", :ua=>"抓", :uo=>"桌", :uai=>"拽", :ui=>"追", :uan=>"專", :un=>"準", :uang=>"裝", :ong=>"㆗"},
      :ch => {:a=>"插", :e=>"車", :i=>"吃", :ai=>"拆", :ao=>"超", :ou=>"抽", :an=>"攙", :en=>"陳", :ang=>"昌", :eng=>"稱", :u=>"初", :uo=>"戳", :uai=>"揣", :ui=>"吹", :uan=>"穿", :un=>"春", :uang=>"窗", :ong=>"充"},
      :sh => {:a=>"沙", :e=>"奢", :i=>"詩", :ai=>"篩", :ei=>"誰", :ao=>"燒", :ou=>"收", :an=>"山", :en=>"伸", :ang=>"傷", :eng=>"生", :u=>"書", :ua=>"刷", :uo=>"說", :uai=>"衰", :ui=>"水", :uan=>"栓", :un=>"順", :uang=>"雙"},
      :r => {:e=>"熱", :i=>"日", :ao=>"繞", :ou=>"柔", :an=>"然", :en=>"㆟", :ang=>"讓", :eng=>"扔", :u=>"如", :uo=>"若", :ui=>"瑞", :uan=>"軟", :un=>"潤", :ong=>"榮"},
      :z => {:a=>"雜", :e=>"則", :i=>"資", :ai=>"災", :ei=>"賊", :ao=>"遭", :ou=>"鄒", :an=>"咱", :en=>"怎", :ang=>"髒", :eng=>"增", :u=>"租", :uo=>"昨", :ui=>"最", :uan=>"鑽", :un=>"尊", :ong=>"宗"},
      :c => {:a=>"擦", :e=>"測", :i=>"雌", :ai=>"猜", :ao=>"曹", :ou=>"湊", :an=>"參", :en=>"岑", :ang=>"倉", :eng=>"層", :u=>"粗", :uo=>"錯", :ui=>"催", :uan=>"篡", :un=>"村", :ong=>"聰"},
      :s => {:a=>"撒", :e=>"色", :i=>"私", :ai=>"腮", :ao=>"搔", :ou=>"搜", :an=>"㆔", :en=>"森", :ang=>"桑", :eng=>"僧", :u=>"蘇", :uo=>"索", :ui=>"雖", :uan=>"酸", :un=>"孫", :ong=>"鬆"},
      :y => {:i=>"衣", :a=>"呀", :e=>"耶", :ao=>"腰", :ou=>"優", :an=>"煙", :in=>"因", :ang=>"央", :ing=>"英", :u=>"迂", :üe=>"約", :üan=>"冤", :ün=>"暈", :ong=>"庸"},
      :w => {:u=>"烏", :a=>"蛙", :o=>"窩", :ai=>"歪", :ei=>"威", :an=>"彎", :en=>"溫", :ang=>"汪", :eng=>"翁"},
      :o => {:a=>"啊", :o=>"喔", :e=>"鵝", :er=>"兒", :ai=>"哀", :ei=>"欸", :ao=>"熬", :ou=>"歐", :an=>"安", :en=>"恩", :ang=>"昂", :eng=>"鞥"}
  }

  # 每個按鍵對應的雙拼表
  VALID_COMPOSITE = {
      :Q => %w(q iu),
      :W => %w(w ia ua),
      :E => %w(e),
      :R => %w(r uan üan er),
      :T => %w(t ue üe),
      :Y => %w(y uai),  #also accept ü, but by 'v' button in general
      :U => %w(u sh),
      :I => %w(i ch),
      :O => %w(o uo),
      :P => %w(p un ün),
      :A => %w(a),
      :S => %w(s ong iong),
      :D => %w(d uang iang),
      :F => %w(f en),
      :G => %w(g eng),
      :H => %w(h ang),
      :J => %w(j an),
      :K => %w(k ao),
      :L => %w(l ai),
      :';' => %w(ing),
      :Z => %w(z ei),
      :X => %w(x ie),
      :C => %w(c iao),
      :V => %w(zh ui ü),
      :B => %w(b ou),
      :N => %w(n in),
      :M => %w(m ian),
  }

  def initialize()
    SHENG_MU.freeze
    YUN_MU.freeze
    LEGAL_COMPOSITE.freeze
    SHENG_YUN_WORD_TABLE.freeze
    VALID_COMPOSITE.freeze
  end

  # 提取隨機文字部分
  def get_rand_sheng_yun_sym()
    sheng = SHENG_MU.keys.sample.to_sym
    yun = LEGAL_COMPOSITE[sheng].sample.to_sym
    [sheng, yun]
  end

  def get_sheng_yun_zy(sheng, yun)
    sheng_zy = SHENG_MU[sheng.to_sym].to_s.strip
    yun_zy = YUN_MU[yun.to_sym].to_s.strip
    [sheng_zy, yun_zy]
  end

  def get_zy(sheng, yun)   #sheng, yun: sym
      shengyun = get_sy(sheng, yun)
      sheng_zy, yun_zy = get_sheng_yun_zy(sheng, yun)
      case shengyun  # special cases for zhuyin required to fine-adjust
        when 'zhi'
          SHENG_MU[:zh]
        when 'chi'
          SHENG_MU[:ch]
        when 'shi'
          SHENG_MU[:sh]
        when 'ri'
          SHENG_MU[:r]
        when 'zi'
          SHENG_MU[:z]
        when 'ci'
          SHENG_MU[:c]
        when 'si'
          SHENG_MU[:s]
        when 'yu', 'yü'
          YUN_MU[:ü]
        when 'yuan', 'yüan'
          YUN_MU[:üan]
        when 'yue', 'yüe'
          YUN_MU[:üe]
        when 'yun', 'yün'
          YUN_MU[:ün]
        when 'yong'
          YUN_MU[:iong]
        when 'ju', 'jü', 'qu', 'qü', 'xu', 'xü'
          (SHENG_MU[sheng] + YUN_MU[:ü]).chars.uniq.join
        else
          (sheng_zy + yun_zy).chars.uniq.join
      end
  end

  def get_sy(sheng, yun)   #sheng, yun: sym
      (sheng.to_s.strip + yun.to_s.strip).sub(/^o/,'')
  end

  def get_cw(sheng, yun)   #sheng, yun: sym
    cw = SHENG_YUN_WORD_TABLE.fetch(sheng.to_sym).fetch(yun.to_sym) rescue puts("內部錯誤：資料中查無此字 【#{sheng}#{yun}】")
    cw ||= ''
  end

  # 計算拼音輸入碼答案部分
  def get_correct_keys(input_pinyin)
    press_keys=''
    input_pinyin = input_pinyin.downcase.strip
    if LEGAL_COMPOSITE[:o].include?(input_pinyin)
      # 說明是韻母單音節字
      press_keys << 'O'
      get_a_press_key(input_pinyin, press_keys) # yun only
      return press_keys
    end

    if input_pinyin.start_with?('zh', 'ch', 'sh')
      get_a_press_key(input_pinyin[0,2], press_keys)  # sheng
      get_a_press_key(input_pinyin[2,input_pinyin.length], press_keys)  # yun
    else
      get_a_press_key(input_pinyin[0,1], press_keys)  # sheng
      get_a_press_key(input_pinyin[1,input_pinyin.length], press_keys)  # yun
    end

    press_keys
  end

  def get_a_press_key(word, press_keys)
    VALID_COMPOSITE.each do |key, value|
      if value.include?(word)
        press_keys << key.to_s
        break
      end
    end
  end
end