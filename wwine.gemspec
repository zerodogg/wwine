# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{wwine}
  s.version = "0.4"

  s.authors = ["Eskild Hustvedt"]
  s.date = %q{2018-04-21}
  s.email = %q{code at zerodogg dot org}
  s.files = [ 'wwine', 'README.md', 'COPYING', 'wwine.1' ]
  s.bindir = '.'
  s.licenses = %q{GPLv3}
  s.executables = [ 'wwine' ]
  s.homepage = %q{http://random.zerodogg.org/wwine}
  s.summary = %q{wwine is a simple wine wrapper.}
  s.description = 'wwine is a a wine(1) wrapper. It wraps various flavours of wine (including vanilla wine and crossover) into a single unified interface, complete with full bottle support for all of them (including vanilla wine).'
end
