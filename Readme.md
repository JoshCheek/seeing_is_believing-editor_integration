Seeing Is Believing editor integration
======================================

[Seeing Is Believing](https://github.com/JoshCheek/seeing_is_believing)
records the result of every line of Ruby code.

The editor integrations allow you to press a button while editing a Ruby file,
and have it passed through Seeing Is Believing,
which will add an annotation (comment) after each line,
showing what it evaluated to.

![example](https://camo.githubusercontent.com/28417dbca9d0a47b64c10be40d2e2fe0e55ff4df/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6a6f73682e636865656b2f696d616765732f736372617463682f7369622d6578616d706c65312e676966)

This repository builds the integration code for each of the editors.
Well... currently it doesn't do shit, but eventually it will,
assuming I succeed.

Editors
-------

* [Atom](https://atom.io/) editor, and [current integration](https://github.com/JoshCheek/atom-seeing-is-believing)
* [Sublime Text 2 and 3](http://www.sublimetext.com/) editors, and [current integration](https://github.com/JoshCheek/sublime-text-2-and-3-seeing-is-believing)
* [Textmate 1/2](http://macromates.com/) editors, and current integration for
  * [TextMate 1](https://github.com/JoshCheek/text_mate_1-seeing-is_believing)
  * [TextMate 2](https://github.com/JoshCheek/text_mate_2-seeing-is_believing)
* [Vim](http://www.vim.org/) editor. There are two integrations, but I didn't write either of them.
  * [vim-ruby-xmpfilter](https://github.com/t9md/vim-ruby-xmpfilter), and
  * [vim-seeing-is-believing](https://github.com/hwartig/vim-seeing-is-believing).
* [Emacs](https://www.gnu.org/software/emacs/) editor. Currently, integration is performed via this script:
  ```lisp
  (defun seeing-is-believing ()
    "Replace the current region (or the whole buffer, if none) with the output
  of seeing_is_believing."
    (interactive)
    (let ((beg (if (region-active-p) (region-beginning) (point-min)))
          (end (if (region-active-p) (region-end) (point-max))))
      (shell-command-on-region beg end "seeing_is_believing" nil 'replace)))
  ```

Packaging
---------

I literally had a student tell me that installing SiB made her cry and wonder if she was cut out for programming :(

So, to make it not a total PITA to install this, I'm packaging Ruby along with it.
This way, if your editor has a package manager, you can just tell it to install the thing,
and you won't have to deal with the headache of hooking it into your environment.

Ruby packaging is done with Traveling Ruby.

* [Traveling Ruby homepage](https://phusion.github.io/traveling-ruby/)
* [The tutorials](https://github.com/phusion/traveling-ruby#getting-started)
  * [Tutorial 1](https://github.com/phusion/traveling-ruby/blob/master/TUTORIAL-1.md) hello, world
  * [Tutorial 2](https://github.com/phusion/traveling-ruby/blob/master/TUTORIAL-2.md) gem dependencies
  * [Tutorial 3](https://github.com/phusion/traveling-ruby/blob/master/TUTORIAL-3.md) native extensions
  * [Tutorial 4](https://github.com/phusion/traveling-ruby/blob/master/TUTORIAL-4.md) creating packages for Windows
* [Ruby Installer](http://rubyinstaller.org/) for Windows integration.
* Traveling Ruby Binaries:
  * [Primary](http://traveling-ruby.s3-us-west-2.amazonaws.com/list.html) (hosted on S3)
  * [Mirror](http://d6r77u77i8pq3.cloudfront.net/) (they say it's faster)
