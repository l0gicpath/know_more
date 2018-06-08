module Translator # :nodoc: all
  class Service
    def self.pick(service)
      configuration = TRANSLATION_CONFIG[service.to_s]
      "Translator::Services::#{service.to_s.capitalize}".constantize.new(configuration)
    rescue NameError
      raise Translator::Error::NonExistingService.new(service.to_s)
    end
  end
end
