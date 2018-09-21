class DigitaloceanVolume < Inspec.resource(1)
  name 'digitalocean_volume'
  desc 'Verifies settings for a Digitalocean volume.'

  supports platform: 'digitalocean'

  example <<-RUBY
    describe #{name}() do
      it { should exist }
    end
  RUBY

  include DigitaloceanBase

  attributes = %w(name ttl zone_file)

  attributes.each do |attribute|
    define_method(attribute) do
      volume.send(attribute)
    end
  end

  def exists?
    volume
  end

  private

  def volume
    @volume ||= volume_for(@options[:name])
  end

  def volume_for(name)
    client.volumes.all.find { |res| res.name == name }
  end
end
