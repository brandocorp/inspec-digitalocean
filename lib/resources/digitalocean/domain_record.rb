class DigitaloceanDomainRecord < Inspec.resource(1)
  name 'digitalocean_domain_record'
  desc 'Verifies settings for a Digitalocean domain record.'

  supports platform: 'digitalocean'

  example <<-RUBY
    describe #{name}() do
      it { should exist }
    end
  RUBY

  include DigitaloceanBase

  attributes = %w(id type name data priority port ttl weight flags tag)

  attributes.each do |attribute|
    define_method(attribute) do
      domain_record.send(attribute)
    end
  end

  def exists?
    domain_record
  end

  private

  def domain_record
    @domain_record ||= domain_record_for(@options[:name])
  end

  def domain_record_for(name)
    client.domain_records.all.find { |res| res.name == name }
  end
end
