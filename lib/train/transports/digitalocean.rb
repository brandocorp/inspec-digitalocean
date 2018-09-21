require 'train/plugins'
require 'droplet_kit'

module Train::Transports
  class Digitalocean < Train.plugin(1)
    name 'digitalocean'

    option :token, default: ENV['DIGITALOCEAN_TOKEN']

    def connection(_ = nil)
      Connection.new(@options)
    end

    class Connection < BaseConnection
      def initialize(options)
        super(options)
        connect
      end

      def client
        @client
      end

      def connect
        @client ||= DropletKit::Client.new(access_token: @options[:token])
      end

      def platform
        force_platform!('digitalocean', uri: options[:uri])
      end

      def uri
        'digitalocean://'
      end

      def run_command_via_connection(cmd)
        logger.debug cmd
      end

      def unique_identifier
        Time.now.to_s
      end
    end
  end
end
