require "translator/errors"
require "translator/service"
require "translator/services/microsoft"
require "translator/services/google"

module Translator # :nodoc:
  @default_service = :google

  class << self
    # The service that will be used for translation
    attr_accessor :service

    ##
    # English_to will accept the text that needs to be translated, the language it
    # needs to translate to and the type of that text (either it's in html or in plain text)
    # Returns the translated text
    #
    # params:
    # +text+:: Text to be translated
    # +lang:+:: Language argument, this is required and can accept any language symbol supported by
    #   the translation service used.
    # +type:+:: Type argument, this defaults to :html and will only accept either :html or :text
    def to(text, lang:, type: :html)
      Translator::Service.pick(@service || @default_service).translate(text, lang, type)
    end
  end
end
