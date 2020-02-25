# 幫助你快速學習雙拼 —— 微軟雙拼（繁體中文版）

### 程序簡介：

一個萌妹子風格的輸入法學習套件，參考新華字典的設定，每次隨機出現出合理的拼音組合。<br>
根據輸出的拼音組合中打出對應的雙拼，每個字用空格隔開，按 Enter 提交，輸入 ```exit``` 提交或者按下 Ctrl+c 退出練習。

快速學習雙拼 程序畫面：\
![image][shuang_pin_tutorial_console]

微軟雙拼鍵盤方案圖：\
![image][shuang_pin_keyboard]

<br>另外，[參考文件夾][folder_img]中附上：

* [普通話聲韻配合表][pthtable]
* [漢語拼音與通用拼音對照表][shuang_pin_200_words_sample]
* [雙拼鍵盤口訣][shuang_pin_keyboard_quote]
* [速成雙拼需學200字][zhuyin_pinyin_conversion_table]

---

### 執行步驟：

如果沒有安裝 Ruby 的情況下，需要先[安裝 Ruby][rubychina_install_ruby]。

安裝與運行：
```bash
gem install shuang_pin_tutorial     # 透過 Gem 安裝學習雙拼套件

shuang_pin_tutorial     # 運行套件
```

[shuang_pin_tutorial_console]: ./img/shuang_pin_tutorial_console.png  "shuang pin tutorial console"
[shuang_pin_keyboard]: ./img/shuang_pin_keyboard.png  "shuang pin keyboard"
[rubychina_install_ruby]: https://ruby-china.org/wiki/install_ruby_guide "ruby-china install ruby method"

[folder_img]: https://github.com/jsdnhk/shuang-pin-tutorial-tw/tree/master/ref
[pthtable]: ./ref/PTHtable_cuhk.pdf
[shuang_pin_200_words_sample]: ./ref/shuang_pin_200_words_sample.txt
[shuang_pin_keyboard_quote]: ./ref/shuang_pin_keyboard_quote.txt
[zhuyin_pinyin_conversion_table]: ./ref/zhuyin_pinyin_conversion_table.pdf
