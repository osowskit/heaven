# -*- encoding: utf-8 -*-
# stub: hipchat 1.6.0 ruby lib

Gem::Specification.new do |s|
  s.name = "hipchat"
  s.version = "1.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["HipChat/Atlassian"]
  s.date = "2017-07-05"
  s.description = "Ruby library to interact with HipChat"
  s.email = ["support@hipchat.com"]
  s.homepage = "https://github.com/hipchat/hipchat-rb"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
  s.rubygems_version = "2.4.8"
  s.summary = "Ruby library to interact with HipChat"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
      s.add_runtime_dependency(%q<mimemagic>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
      s.add_development_dependency(%q<rr>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.14.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<webmock>, ["> 1.22.6"])
      s.add_development_dependency(%q<addressable>, ["= 2.4.0"])
      s.add_development_dependency(%q<term-ansicolor>, ["~> 1.4.0"])
      s.add_development_dependency(%q<json>, ["> 1.8.4"])
      s.add_development_dependency(%q<rdoc>, ["> 2.4.2"])
      s.add_development_dependency(%q<tins>, ["~> 1.6.0"])
      s.add_development_dependency(%q<coveralls>, [">= 0"])
    else
      s.add_dependency(%q<httparty>, [">= 0"])
      s.add_dependency(%q<mimemagic>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 3.0"])
      s.add_dependency(%q<rr>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.14.0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<webmock>, ["> 1.22.6"])
      s.add_dependency(%q<addressable>, ["= 2.4.0"])
      s.add_dependency(%q<term-ansicolor>, ["~> 1.4.0"])
      s.add_dependency(%q<json>, ["> 1.8.4"])
      s.add_dependency(%q<rdoc>, ["> 2.4.2"])
      s.add_dependency(%q<tins>, ["~> 1.6.0"])
      s.add_dependency(%q<coveralls>, [">= 0"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0"])
    s.add_dependency(%q<mimemagic>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 3.0"])
    s.add_dependency(%q<rr>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.14.0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<webmock>, ["> 1.22.6"])
    s.add_dependency(%q<addressable>, ["= 2.4.0"])
    s.add_dependency(%q<term-ansicolor>, ["~> 1.4.0"])
    s.add_dependency(%q<json>, ["> 1.8.4"])
    s.add_dependency(%q<rdoc>, ["> 2.4.2"])
    s.add_dependency(%q<tins>, ["~> 1.6.0"])
    s.add_dependency(%q<coveralls>, [">= 0"])
  end
end
