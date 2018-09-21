class DigitaloceanDomain < Inspec.resource(1)
  name 'digitalocean_domain'
  desc 'Verifies settings for a Digitalocean domain.'

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
      domain.send(attribute)
    end
  end

  def exists?
    domain
  end

  private

  def domain
    @domain ||= domain_for(@options[:name])
  end

  def domain_for(name)
    client.domains.all.find { |res| res.name == name }
  end
end
