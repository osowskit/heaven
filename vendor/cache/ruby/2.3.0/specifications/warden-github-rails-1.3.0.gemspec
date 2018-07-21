# -*- encoding: utf-8 -*-
# stub: warden-github-rails 1.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "warden-github-rails"
  s.version = "1.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Philipe Fatio"]
  s.date = "2017-05-16"
  s.description = "An easy drop in solution for rails to use GitHub authentication."
  s.email = ["me@phili.pe"]
  s.homepage = "https://github.com/fphilipe/warden-github-rails"
  s.rubygems_version = "2.4.8"
  s.summary = "An easy drop in solution for rails to use GitHub authentication."

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 3.1"])
      s.add_development_dependency(%q<rails>, [">= 3.2"])
      s.add_development_dependency(%q<rack-test>, ["~> 0.6"])
      s.add_development_dependency(%q<addressable>, ["~> 2.3"])
      s.add_development_dependency(%q<coveralls>, [">= 0"])
      s.add_runtime_dependency(%q<warden-github>, [">= 1.3.2", "~> 1.3"])
      s.add_runtime_dependency(%q<railties>, [">= 3.1"])
    else
      s.add_dependency(%q<rspec>, ["~> 3.1"])
      s.add_dependency(%q<rails>, [">= 3.2"])
      s.add_dependency(%q<rack-test>, ["~> 0.6"])
      s.add_dependency(%q<addressable>, ["~> 2.3"])
      s.add_dependency(%q<coveralls>, [">= 0"])
      s.add_dependency(%q<warden-github>, [">= 1.3.2", "~> 1.3"])
      s.add_dependency(%q<railties>, [">= 3.1"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 3.1"])
    s.add_dependency(%q<rails>, [">= 3.2"])
    s.add_dependency(%q<rack-test>, ["~> 0.6"])
    s.add_dependency(%q<addressable>, ["~> 2.3"])
    s.add_dependency(%q<coveralls>, [">= 0"])
    s.add_dependency(%q<warden-github>, [">= 1.3.2", "~> 1.3"])
    s.add_dependency(%q<railties>, [">= 3.1"])
  end
end
