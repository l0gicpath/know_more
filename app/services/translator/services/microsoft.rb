require 'net/https'
require 'uri'
require 'cgi'
require 'json'
require 'securerandom'

module Translator # :nodoc:
  module Services

    ##
    # +Microsoft+ is a +Translator+ service that integrates with the Microsoft translation API v3
    # It's a service because it confronts to the +Service+ contract which is to have a #translate
    # method as part of its public API interface
    # All Translation services should expect a configuration hash sent to their constructors
    class Microsoft

      def initialize(config)
        raise Translator::Error::MissingConfiguration.new("microsoft", "key config variable is required") unless is_config_valid?(config)
        @config = config
        @host = 'https://api.cognitive.microsofttranslator.com/translate?api-version=3.0'
      end

      ##
      # Translate accepts a text, a language to translate to and the type of text passed to the service
      # Returns the translated text
      #
      # params:
      # +text+:: The text to be translated, can be either plain text or HTML, the +type+ argument has to be set accordingly
      # +lang+:: The language to translate into, should be in short form like "de" or "fr"
      # +type+:: The type of the text being translated, it's either :html or :text
      def translate(text, lang, type)
        params = "&to=#{lang.to_s}&textType=#{type.to_s}"
        uri = URI(@host + params)
        content = "[{\"Text\": \"#{text}\"}]"

        request = Net::HTTP::Post.new(uri)
        request['Content-type'] = 'application/json'
        request['Content-length'] = content.length
        request['Ocp-Apim-Subscription-Key'] = @config["key"]
        request['X-ClientTraceId'] = SecureRandom.uuid
        request.body = content

        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
          http.request(request)
        end

        result = response.body.force_encoding("utf-8")
        json = JSON.parse(result)

        response_code = response.code.to_i
        if response_code >= 200 && response_code < 300
          json[0]["translations"][0]["text"]
        else
          raise Translator::Error::ServiceError.new("microsoft", json["error"]["message"])
        end
      end

      private
      def is_config_valid?(config)
        !config.nil? && config.has_key?("key")
      end
    end
  end
end
