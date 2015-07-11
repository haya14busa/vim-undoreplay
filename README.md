:movie_camera: vim-undoreplay :movie_camera:
============================================

![undoreplay_fizzbuzz2.gif](https://raw.githubusercontent.com/haya14busa/i/master/vim-undoreplay/undoreplay_fizzbuzz2.gif)

<blockquote class="twitter-tweet" lang="en"><p lang="ja" dir="ltr">自分のLispコーディングを最初から完成までをRedoで再生してみたんだけど、自分で見ていても結構面白かった。こういうプラグインがあると良さそうだなー <a href="http://t.co/yvzMgyFBMT">pic.twitter.com/yvzMgyFBMT</a></p>&mdash; えせはら(似非原重雄) (@esehara) <a href="https://twitter.com/esehara/status/619209440768729088">July 9, 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

### Installation

[Neobundle](https://github.com/Shougo/neobundle.vim) / [Vundle](https://github.com/gmarik/Vundle.vim) / [vim-plug](https://github.com/junegunn/vim-plug)

```vim
NeoBundle 'haya14busa/vim-undoreplay'
Plugin 'haya14busa/vim-undoreplay'
Plug 'haya14busa/vim-undoreplay'
```

### Usage

```
:UndoReplay
```

#### Keymappings

| Keymap           | Details             |
| ---------------- | ------------------- |
| `<Up>` or `k`    | Speed up            |
| `<Down>` or `j`  | Speed down          |
| `<Space>`        | stop/restart replay |
| `<Right>` or `l` | next step           |
| `<Left>` or `h`  | previous step       |
| `?`              | show help           |
