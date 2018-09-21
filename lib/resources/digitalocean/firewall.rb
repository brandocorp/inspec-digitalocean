class DigitaloceanFirewall < Inspec.resource(1)
  name 'digitalocean_firewall'
  desc 'Verifies settings for a Digitalocean firewall.'

  supports platform: 'digitalocean'

  example <<-RUBY
    describe #{name}() do
      it { should exist }
    end
  RUBY

  include DigitaloceanBase

  attributes = %w(id status pending_changes name inbound_rules outbound_rules
    droplet_ids tags)

  attributes.each do |attribute|
    define_method(attribute) do
      firewall.send(attribute)
    end
  end

  def exists?
    firewall
  end

  private

  def firewall
    @firewall ||= firewall_for(@options[:name])
  end

  def firewall_for(name)
    client.firewalls.all.find { |res| res.name == name }
  end
end
