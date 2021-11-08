# README

## Install Jekyll

* Install Ruby (with Devkit) from <https://rubyinstaller.org/downloads/>
* On final installer screen, select "ridk install"; Choose option 3 (MSYS2 and MINGW)
* In new command prompt (NB: not running as admin), run `gem install jekyll bundler`
* Verify installation using `jekyll -v`

## Install site dependencies

* Clone the repo
* Navigate to the /docs folder in repo
* Check the Gemfile for a line starting `gem "webrick"`
* If the line is missing then type _`bundle add webrick` (see <https://github.com/jekyll/jekyll/issues/8523>)_ otherwise skip step
* Install bundle by typing command: `bundle`

## Jekyll Serve

* Navigate to root of repo
* Either execute the following shortcut file `./serve.cmd`, or
* *Direct command: `bundle exec jekyll serve` (cd into `./docs` first)*

## TODO

* [x] Jekyll setup / Gemfile
* [x] GA
* [x] Landing Page
* [x] Footer Logo
* [x] Blog
* [x] `feed.xml`
* [x] Top Nav
* [x] Side Bar
* [x] Remove all obsolete artifacts
* [ ] Tools - Getting Started
* [ ] Tools: Use <https://shields.io/category/version>
* [ ] Features
* [ ] About/Contact
* [ ] Search
* [ ] jQuery syntax error
* [ ] Articles
* [ ] Tags
* [ ] Commento.io
* [ ] Collapsible TOC?
* [ ] Favicon

## GitHub Pages / Jekyll Docs

* <https://jekyllrb.com/docs/>
* <https://jekyllrb.com/docs/configuration/options/>
* <https://jekyllrb.com/docs/pages/>
* <https://jekyllrb.com/docs/posts/>
* <https://jekyllrb.com/docs/variables/>
* <https://jekyllrb.com/docs/includes/>
* [Liquid Reference](https://shopify.github.io/liquid/)
* [Liquid in Jekyll](https://jekyllrb.com/docs/liquid/)

## External Dependencies

* [Font Awesome v4.7](https://fontawesome.com/v4.7/cheatsheet/)
* [Bootstrap 3.3.7](https://getbootstrap.com/docs/3.3/getting-started/)
* [jQuery 3.3.1](https://api.jquery.com/category/version/3.3/)
* [Navgoco jQuery plugin](https://github.com/tefra/navgoco)

## About: Jekyll Collections

* <https://ben.balter.com/2015/02/20/jekyll-collections/>

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
