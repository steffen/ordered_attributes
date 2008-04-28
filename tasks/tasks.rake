require 'spec/rake/spectask'

namespace :ordinary_attributes do
  # namespace :spec do
    desc "Runs the examples for rspec_on_rails"
    Spec::Rake::SpecTask.new(:spec) do |t|
      t.spec_opts = ['--options', "\"#{RAILS_ROOT}/spec/spec.opts\""]
      t.spec_files = FileList['vendor/plugins/ordinary_attributes/spec/**/*_spec.rb']
    end
  # end
end