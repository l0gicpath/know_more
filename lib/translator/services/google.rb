require 'google/cloud/translate'

module Translator # :nodoc:
  module Services

    ##
    # +Google+ is a +Translator+ service that integrates with the Google Cloud translation API
    # It's a service because it confronts to the +Service+ contract which is to have a #translate
    # method as part of its public API interface
    # All Translation services should expect a configuration hash sent to their constructors
    class Google

      def initialize(config)
        @config = config
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
        translation = translate_client.translate(text,
                                                 to: lang.to_s,
                                                 format: type)
        translation.text
      rescue StandardError => err
        puts err.inspect
        raise Translator::Error::ServiceError.new("google", err.to_s)
      end

      private
      def translate_client
        @translate_client ||= ::Google::Cloud::Translate.new(project: @config['project_id'],
                                                             credentials: @config["key_file"])
      end
    end
  end
end
