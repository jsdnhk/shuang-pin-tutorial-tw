# 幫助你快速學習雙拼 -- 微軟雙拼（繁體中文版）【測試版】

一個萌妹子風格的腳本文件，參考新華字典的設定，每次隨機出現出合理的拼音組合，\
根據輸出的拼音組合中打出對應的雙拼，每個字用空格隔開，按Enter提交。

快速學習雙拼 程序畫面：
![image][shuang_pin_tutorial_console]

微軟雙拼鍵盤方案圖：
![image][shuang_pin_keyboard]

在[作者(HuaWeng@GitHub)][arthor_github][原版][origin_shuang_pin_tutorial]上新增功能：
- [x] 繁體中文化
- [x] 注音顯示
- [x] 例字顯示

./ref/ 參考文件檔中附上：
+ [普通話聲韻配合表][pthtable]
+ [漢語拼音與通用拼音對照表][shuang_pin_200_words_sample]
+ [雙拼鍵盤口訣][shuang_pin_keyboard_quote]
+ [速成雙拼需學200字][zhuyin_pinyin_conversion_table]

步驟：

1) 如果沒有安裝ruby 的情況下，需要先[安裝ruby][rubychina_install_ruby]

2) 在 `shuang_pin_tutorial.rb` 同級目錄下，執行下面命令即可
```sh
ruby shuang_pin_tutorial.rb     #Windows/MacOS/Linux

./shuang_pin_tutorial.rb    #Alternative of MacOS/Linux
```

[shuang_pin_tutorial_console]: ./img/shuang_pin_tutorial_console.png  "shuang pin tutorial console"
[arthor_github]: https://github.com/HuaWeng  "HuaWeng github page"
[origin_shuang_pin_tutorial]: https://github.com/HuaWeng/shuang_pin_tutorial "origin shuang pin tutorial"
[shuang_pin_keyboard]: ./img/shuang_pin_keyboard.png  "shuang pin keyboard"
[rubychina_install_ruby]: https://ruby-china.org/wiki/install_ruby_guide "ruby-china install ruby method"

[pthtable]: ./ref/PTHtable_cuhk.pdf
[shuang_pin_200_words_sample]: ./ref/shuang_pin_200_words_sample.txt
[shuang_pin_keyboard_quote]: ./ref/shuang_pin_keyboard_quote.txt
[zhuyin_pinyin_conversion_table]: ./ref/zhuyin_pinyin_conversion_table.pdf