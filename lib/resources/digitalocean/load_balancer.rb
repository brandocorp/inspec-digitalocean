class DigitaloceanLoadBalancer < Inspec.resource(1)
  name 'digitalocean_load_balancer'
  desc 'Verifies settings for a Digitalocean load_balancer.'

  supports platform: 'digitalocean'

  example <<-RUBY
    describe #{name}() do
      it { should exist }
    end
  RUBY

  include DigitaloceanBase

  attributes = %w(id name ip algorithm status forwarding_rules health_check
    sticky_sessions region tag droplet_ids redirect_http_to_https)

  attributes.each do |attribute|
    define_method(attribute) do
      load_balancer.send(attribute)
    end
  end

  def exists?
    load_balancer
  end

  private

  def load_balancer
    @load_balancer ||= load_balancer_for(@options[:name])
  end

  def load_balancer_for(name)
    client.load_balancers.all.find { |res| res.name == name }
  end
end
