transprt
========

[![Gem Version](https://badge.fury.io/rb/transprt.png)](http://badge.fury.io/rb/transprt)
[![Dependency Status](https://gemnasium.com/ghn/transprt.png)](https://gemnasium.com/ghn/transprt)

Use the Swiss public transport API (open data). http://transport.opendata.ch

Installation
============

```
gem install transprt
```

Usage
=====

```
$ irb
$ require 'transprt'
$ Transprt.locations :query => 'geneva'
```
