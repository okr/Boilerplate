# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rugalytics}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rob McKinnon"]
  s.date = %q{2009-04-16}
  s.default_executable = %q{rugalytics}
  s.description = %q{Rugalytics is a Ruby API for Google Analytics.}
  s.email = ["rob ~@nospam@~ rubyforge.org"]
  s.executables = ["rugalytics"]
  s.extra_rdoc_files = ["CHANGELOG", "LICENSE", "README"]
  s.files = ["CHANGELOG", "lib/rugalytics/account.rb", "lib/rugalytics/connection.rb", "lib/rugalytics/graph.rb", "lib/rugalytics/item.rb", "lib/rugalytics/profile.rb", "lib/rugalytics/report.rb", "lib/rugalytics/server.rb", "lib/rugalytics/rugrat.user.js", "lib/rugalytics.rb", "LICENSE", "Manifest", "README", "README.rdoc", "bin/rugalytics", "rugalytics.yml.example", "spec/fixtures/analytics_account_find_all.html", "spec/fixtures/analytics_profile_find_all.html", "spec/fixtures/dashboard_report_webgroup.xml", "spec/lib/rugalytics/account_spec.rb", "spec/lib/rugalytics/graph_spec.rb", "spec/lib/rugalytics/item_spec.rb", "spec/lib/rugalytics/profile_spec.rb", "spec/lib/rugalytics/report_spec.rb", "spec/lib/rugalytics_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "rugalytics.gemspec", "Rakefile"]
  s.has_rdoc = true
  s.homepage = %q{}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Rugalytics", "--main", "README", "--inline-source"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rugalytics}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Rugalytics is a Ruby API for Google Analytics.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hpricot>, [">= 0.6"])
      s.add_runtime_dependency(%q<activesupport>, [">= 2.0.2"])
      s.add_runtime_dependency(%q<googlebase>, [">= 0.2.0"])
      s.add_runtime_dependency(%q<morph>, [">= 0.2.7"])
      s.add_runtime_dependency(%q<fastercsv>, [">= 1.4.0"])
      s.add_runtime_dependency(%q<rack>, [">= 0.4.0"])
    else
      s.add_dependency(%q<hpricot>, [">= 0.6"])
      s.add_dependency(%q<activesupport>, [">= 2.0.2"])
      s.add_dependency(%q<googlebase>, [">= 0.2.0"])
      s.add_dependency(%q<morph>, [">= 0.2.7"])
      s.add_dependency(%q<fastercsv>, [">= 1.4.0"])
      s.add_dependency(%q<rack>, [">= 0.4.0"])
    end
  else
    s.add_dependency(%q<hpricot>, [">= 0.6"])
    s.add_dependency(%q<activesupport>, [">= 2.0.2"])
    s.add_dependency(%q<googlebase>, [">= 0.2.0"])
    s.add_dependency(%q<morph>, [">= 0.2.7"])
    s.add_dependency(%q<fastercsv>, [">= 1.4.0"])
    s.add_dependency(%q<rack>, [">= 0.4.0"])
  end
end
