# -*- encoding: utf-8 -*-
# stub: resque-lock-timeout 0.4.5 ruby lib

Gem::Specification.new do |s|
  s.name = "resque-lock-timeout"
  s.version = "0.4.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Luke Antins", "Ryan Carver", "Chris Wanstrath"]
  s.date = "2015-08-04"
  s.description = "  A Resque plugin. Adds locking, with optional timeout/deadlock handling to\n  resque jobs.\n\n  Using a `lock_timeout` allows you to re-acquire the lock should your worker\n  fail, crash, or is otherwise unable to relase the lock.\n  \n  i.e. Your server unexpectedly looses power. Very handy for jobs that are\n  recurring or may be retried.\n"
  s.email = "luke@lividpenguin.com"
  s.homepage = "http://github.com/lantins/resque-lock-timeout"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "A Resque plugin adding locking, with optional timeout/deadlock handling to resque jobs."

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<resque>, ["~> 1.22"])
      s.add_development_dependency(%q<rake>, ["~> 10.3"])
      s.add_development_dependency(%q<minitest>, ["~> 5.2"])
      s.add_development_dependency(%q<yard>, ["~> 0.8"])
      s.add_development_dependency(%q<simplecov>, [">= 0.7.1", "~> 0.7"])
    else
      s.add_dependency(%q<resque>, ["~> 1.22"])
      s.add_dependency(%q<rake>, ["~> 10.3"])
      s.add_dependency(%q<minitest>, ["~> 5.2"])
      s.add_dependency(%q<yard>, ["~> 0.8"])
      s.add_dependency(%q<simplecov>, [">= 0.7.1", "~> 0.7"])
    end
  else
    s.add_dependency(%q<resque>, ["~> 1.22"])
    s.add_dependency(%q<rake>, ["~> 10.3"])
    s.add_dependency(%q<minitest>, ["~> 5.2"])
    s.add_dependency(%q<yard>, ["~> 0.8"])
    s.add_dependency(%q<simplecov>, [">= 0.7.1", "~> 0.7"])
  end
end
