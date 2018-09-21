class DigitaloceanImage < Inspec.resource(1)
  name 'digitalocean_image'
  desc 'Verifies settings for a Digitalocean image.'

  supports platform: 'digitalocean'

  example <<-RUBY
    describe #{name}() do
      it { should exist }
    end
  RUBY

  include DigitaloceanBase

  attributes = %w(id name type distribution slug public regions min_disk_size
    size_gigabytes)

  attributes.each do |attribute|
    define_method(attribute) do
      image.send(attribute)
    end
  end

  def exists?
    image
  end

  private

  def image
    @image ||= image_for(@options[:name])
  end

  def image_for(name)
    client.images.all.find { |res| res.name == name }
  end
end
