module Translator
  module Error
    class TranslatorError < StandardError
      attr_reader :service
      def initialize(service, message = "")
        @service = service
        super "#{service.capitalize} #{message}"
      end
    end

    class ServiceError < TranslatorError; end
    class NonExistingService < TranslatorError; end
    class MissingConfiguration < TranslatorError; end
  end
end
