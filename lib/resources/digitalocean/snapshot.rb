class DigitaloceanSnapshot < Inspec.resource(1)
  name 'digitalocean_snapshot'
  desc 'Verifies settings for a Digitalocean snapshot.'

  supports platform: 'digitalocean'

  example <<-RUBY
    describe #{name}() do
      it { should exist }
    end
  RUBY

  include DigitaloceanBase

  attributes = %w(id name created_at regions resource_id resource_type
    min_disk_size size_in_gigabytes)

  attributes.each do |attribute|
    define_method(attribute) do
      snapshot.send(attribute)
    end
  end

  def exists?
    snapshot
  end

  private

  def snapshot
    @snapshot ||= snapshot_for(@options[:name])
  end

  def snapshot_for(name)
    client.snapshots.all.find { |res| res.name == name }
  end
end
