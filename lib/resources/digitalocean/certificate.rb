class DigitaloceanCertificate < Inspec.resource(1)
  name 'digitalocean_certificate'
  desc 'Verifies settings for a Digitalocean certificate.'

  supports platform: 'digitalocean'

  example <<-RUBY
    describe #{name}() do
      it { should exist }
    end
  RUBY

  include DigitaloceanBase

  attributes = %w(id name not_after sha1_fingerprint dns_names state type)

  attributes.each do |attribute|
    define_method(attribute) do
      certificate.send(attribute)
    end
  end

  def exists?
    certificate
  end

  private

  def certificate
    @certificate ||= certificate_for(@options[:name])
  end

  def certificate_for(name)
    client.certificates.all.find { |res| res.name == name }
  end
end
