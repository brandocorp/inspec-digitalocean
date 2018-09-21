class DigitaloceanSshKey < Inspec.resource(1)
  name 'digitalocean_ssh_key'
  desc 'Verifies settings for a Digitalocean SSH key.'

  supports platform: 'digitalocean'

  example <<-RUBY
    describe #{name}() do
      it { should exist }
    end
  RUBY

  include DigitaloceanBase

  attributes = %w(id fingerprint public_key name)

  attributes.each do |attribute|
    define_method(attribute) do
      ssh_key.send(attribute)
    end
  end

  def exists?
    ssh_key
  end

  private

  def ssh_key
    @ssh_key ||= ssh_key_for(@options[:name])
  end

  def ssh_key_for(name)
    client.ssh_keys.all.find { |res| res.name == name }
  end
end
