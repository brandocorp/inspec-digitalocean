# encoding: utf-8
# copyright: 2018, The Authors

title 'Digitalocean Tests'

describe digitalocean_droplet(name: 'test-droplet') do
  it           { is_expected.to exist }
  its(:name)   { is_expected.to eq('test-droplet') }
  its(:vcpus)  { is_expected.to eq(1) }
  its(:memory) { is_expected.to eq(512) }
end

describe digitalocean_firewall(name: 'test-firewall') do
  it { is_expected.to exist }
end
