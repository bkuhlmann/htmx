# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "htmx"
  spec.version = "3.0.0"
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://alchemists.io/projects/htmx"
  spec.summary = "An augmenter and companion to the HTMX JavaScript library."
  spec.license = "Hippocratic-2.1"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/htmx/issues",
    "changelog_uri" => "https://alchemists.io/projects/htmx/versions",
    "homepage_uri" => "https://alchemists.io/projects/htmx",
    "funding_uri" => "https://github.com/sponsors/bkuhlmann",
    "label" => "HTMX",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/bkuhlmann/htmx"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = ">= 4.0"

  spec.add_dependency "refinements", "~> 14.0"
  spec.add_dependency "zeitwerk", "~> 2.7"

  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.files = Dir["*.gemspec", "lib/**/*"]
end
