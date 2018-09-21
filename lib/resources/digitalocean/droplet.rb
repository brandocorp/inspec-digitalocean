class DigitaloceanDroplet < Inspec.resource(1)
  name 'digitalocean_droplet'
  desc 'Verifies settings for a Digitalocean droplet.'

  supports platform: 'digitalocean'

  example <<-RUBY
    describe #{name}() do
      it { should exist }
    end
  RUBY

  include DigitaloceanBase

  attributes = %w(id name memory vcpus disk locked status backup_ids
    snapshot_ids features region size image size_slug networks kernel
    next_backup_window tags volume_ids)

  attributes.each do |attribute|
    define_method(attribute) do
      droplet.send(attribute)
    end
  end

  def exists?
    droplet
  end

  private

  def droplet
    @droplet ||= droplet_for(@options[:name])
  end

  def droplet_for(name)
    client.droplets.all.find { |res| res.name == name }
  end
end
