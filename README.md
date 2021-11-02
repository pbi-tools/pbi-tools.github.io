# README

## Install Jekyll

* Install Ruby (with Devkit) from <https://rubyinstaller.org/downloads/>
* On final installer screen, select "ridk install"; Choose option 3 (MSYS2 and MINGW)
* In new command prompt, run `gem install jekyll bundler`
* Verify installation using `jekyll -v`

## Install site dependencies

* _`bundle add webrick` (see <https://github.com/jekyll/jekyll/issues/8523>)_
* Install: `bundle`

## Jekyll Serve

* `./serve.cmd`
* *Direct command: `bundle exec jekyll serve` (cd into `./docs` first)*

## TODO

* [x] Jekyll setup / Gemfile
* [x] GA
* [ ] Landing Page
* [x] Footer Logo
* [ ] Tools - Getting Started
* [ ] Articles
* [ ] Blog
* [ ] About
* [ ] `feed.xml`
* [ ] Top Nav
* [ ] Side Bar
* [ ] Search
* [ ] jquery syntax error
* [ ] Tags
* [ ] Remove all obsolete artifacts

## GitHub Pages / Jekyll Docs

* <https://jekyllrb.com/docs/>
* <https://jekyllrb.com/docs/configuration/options/>
* <https://jekyllrb.com/docs/pages/>
* <https://jekyllrb.com/docs/posts/>
* <https://jekyllrb.com/docs/variables/>
* <https://jekyllrb.com/docs/includes/>
* [Liquid Reference](https://shopify.github.io/liquid/)

## Howto: New Article

## Howto: New Post

## Howto: Images

## Page Composition

* Layout: default
  * Include: head.html
  * Include: topnav.html
  * _Include: sidebar.html_
  * **Content**
    * Layout: page
      * _Include: toc.html_
      * CONTENT
      * Include: footer.html
