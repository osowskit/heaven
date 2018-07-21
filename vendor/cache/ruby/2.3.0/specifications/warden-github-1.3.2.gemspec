# -*- encoding: utf-8 -*-
# stub: warden-github 1.3.2 ruby lib

Gem::Specification.new do |s|
  s.name = "warden-github"
  s.version = "1.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Corey Donohoe"]
  s.date = "2017-05-15"
  s.description = "A warden strategy for easy oauth integration with github"
  s.email = ["atmos@atmos.org"]
  s.homepage = "http://github.com/atmos/warden-github"
  s.licenses = ["MIT"]
  s.rubyforge_project = "warden-github"
  s.rubygems_version = "2.4.8"
  s.summary = "A warden strategy for easy oauth integration with github"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<warden>, ["> 1.0"])
      s.add_runtime_dependency(%q<octokit>, ["> 2.1.0"])
      s.add_runtime_dependency(%q<activesupport>, ["> 3.0"])
      s.add_development_dependency(%q<rack>, ["~> 1.4.1"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.6"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<webmock>, ["~> 1.9"])
      s.add_development_dependency(%q<sinatra>, [">= 0"])
      s.add_development_dependency(%q<shotgun>, [">= 0"])
      s.add_development_dependency(%q<addressable>, ["> 2.2.0"])
      s.add_development_dependency(%q<rack-test>, ["~> 0.5.3"])
      s.add_development_dependency(%q<yajl-ruby>, [">= 0"])
    else
      s.add_dependency(%q<warden>, ["> 1.0"])
      s.add_dependency(%q<octokit>, ["> 2.1.0"])
      s.add_dependency(%q<activesupport>, ["> 3.0"])
      s.add_dependency(%q<rack>, ["~> 1.4.1"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 3.6"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<webmock>, ["~> 1.9"])
      s.add_dependency(%q<sinatra>, [">= 0"])
      s.add_dependency(%q<shotgun>, [">= 0"])
      s.add_dependency(%q<addressable>, ["> 2.2.0"])
      s.add_dependency(%q<rack-test>, ["~> 0.5.3"])
      s.add_dependency(%q<yajl-ruby>, [">= 0"])
    end
  else
    s.add_dependency(%q<warden>, ["> 1.0"])
    s.add_dependency(%q<octokit>, ["> 2.1.0"])
    s.add_dependency(%q<activesupport>, ["> 3.0"])
    s.add_dependency(%q<rack>, ["~> 1.4.1"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 3.6"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<webmock>, ["~> 1.9"])
    s.add_dependency(%q<sinatra>, [">= 0"])
    s.add_dependency(%q<shotgun>, [">= 0"])
    s.add_dependency(%q<addressable>, ["> 2.2.0"])
    s.add_dependency(%q<rack-test>, ["~> 0.5.3"])
    s.add_dependency(%q<yajl-ruby>, [">= 0"])
  end
end
