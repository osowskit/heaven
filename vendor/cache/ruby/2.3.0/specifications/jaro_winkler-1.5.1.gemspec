# -*- encoding: utf-8 -*-
# stub: jaro_winkler 1.5.1 ruby lib
# stub: ext/jaro_winkler/extconf.rb

Gem::Specification.new do |s|
  s.name = "jaro_winkler"
  s.version = "1.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jian Weihang"]
  s.date = "2018-06-06"
  s.description = "jaro_winkler is an implementation of Jaro-Winkler \\\n  distance algorithm which is written in C extension and will fallback to pure \\\n  Ruby version in platforms other than MRI/KRI like JRuby or Rubinius. Both of \\\n  C and Ruby implementation support any kind of string encoding, such as \\\n  UTF-8, EUC-JP, Big5, etc."
  s.email = "tonytonyjan@gmail.com"
  s.extensions = ["ext/jaro_winkler/extconf.rb"]
  s.files = ["ext/jaro_winkler/extconf.rb"]
  s.homepage = "https://github.com/tonytonyjan/jaro_winkler"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "An implementation of Jaro-Winkler distance algorithm written \\ in C extension which supports any kind of string encoding."

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.7"])
      s.add_development_dependency(%q<rake>, ["~> 12.0"])
      s.add_development_dependency(%q<rake-compiler>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.7"])
      s.add_dependency(%q<rake>, ["~> 12.0"])
      s.add_dependency(%q<rake-compiler>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.7"])
    s.add_dependency(%q<rake>, ["~> 12.0"])
    s.add_dependency(%q<rake-compiler>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
  end
end
