#!/usr/bin/env rake

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'

attributes = 'attributes.yml'
fixtures   = 'test/fixtures'
tf_vars    = 'terraform.tfvars'
tf_plan    = 'tf.plan'

verify_command = %Q(
  bundle exec inspec exec %s/verify --attrs %s/verify/%s -t digitalocean://;
  rc=$?;
  if [ $rc -eq 0 ] || [ $rc -eq 101 ]; then
    exit 0;
  else
    exit 1;
  fi
)

check_command = %Q(
  bundle exec inspec check %s
)

init_command = %Q(
  cd %s/build/ && terraform init
)

plan_command = %Q(
  cd %s/build/ && terraform plan -out %s
)

apply_command = %Q(
  cd %s/build/ && terraform apply %s
)

destroy_command = %Q(
  cd %s/build/ && terraform destroy -force || true
)

check_command = %Q(
  bundle exec inspec check %s/verify
)

# Rubocop
desc 'Run Rubocop lint checks'
task :rubocop do
  RuboCop::RakeTask.new
end

# lint the project
desc 'Run robocop linter'
task lint: [:rubocop]

# run tests
task default: [:lint, 'test:check']

namespace :test do
  desc 'Inspec check'
  task :check do
    cmd = format(check_command, fixtures)
    sh(cmd)
  end

  desc 'Inspec exec'
  task :verify do
    cmd = format(verify_command, fixtures, fixtures, attributes)
    sh(cmd)
  end

  desc 'Terraform init'
  task :init do
    cmd = format(init_command, fixtures)
    sh(cmd)
  end

  desc 'Terraform plan'
  task :plan do
    cmd = format(plan_command, fixtures, tf_plan)
    sh(cmd)
  end

  desc 'Terraform apply'
  task :apply do
    cmd = format(apply_command, fixtures, tf_plan)
    sh(cmd)
  end

  desc 'Terraform destroy'
  task :destroy do
    cmd = format(destroy_command, fixtures, tf_vars)
    sh(cmd)
  end
end

desc "Perform Integration Tests"
task :integration do
  Rake::Task["test:init"].execute
  Rake::Task["test:plan"].execute
  Rake::Task["test:apply"].execute
  Rake::Task["test:verify"].execute
  Rake::Task["test:destroy"].execute
end

begin
  require 'github_changelog_generator/task'
  GitHubChangelogGenerator::RakeTask.new :changelog
rescue LoadError
  puts '>>>>> GitHub Changelog Generator not loaded, omitting tasks'
end
