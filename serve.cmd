@ECHO OFF

PUSHD %~dp0docs

bundle exec jekyll serve --incremental

POPD