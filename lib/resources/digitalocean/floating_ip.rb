class DigitaloceanFloatingIp < Inspec.resource(1)
  name 'digitalocean_floating_ip'
  desc 'Verifies settings for a Digitalocean floating IP.'

  supports platform: 'digitalocean'

  example <<-RUBY
    describe #{name}() do
      it { should exist }
    end
  RUBY

  include DigitaloceanBase

  attributes = %w(ip region droplet)

  attributes.each do |attribute|
    define_method(attribute) do
      floating_ip.send(attribute)
    end
  end

  def exists?
    floating_ip
  end

  private

  def floating_ip
    @floating_ip ||= floating_ip_for(@options[:name])
  end

  def floating_ip_for(name)
    client.floating_ips.all.find { |res| res.name == name }
  end
end
