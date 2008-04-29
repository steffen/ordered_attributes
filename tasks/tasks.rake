require 'spec/rake/spectask'

namespace :ordered_attributes do
  # namespace :spec do
    desc "Runs the examples for rspec_on_rails"
    Spec::Rake::SpecTask.new(:spec) do |t|
      t.spec_opts = ['--options', "\"#{RAILS_ROOT}/spec/spec.opts\""]
      t.spec_files = FileList['vendor/plugins/ordered_attributes/spec/**/*_spec.rb']
    end
  # end
end