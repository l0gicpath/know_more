require 'net/https'
require 'uri'
require 'cgi'
require 'json'
require 'securerandom'
module MsTranslator
  @@host = 'https://api.cognitive.microsofttranslator.com'
  @@path = '/translate?api-version=3.0'

  def self.translate(text, to)
    key = MST["key"]
    params = "&to=#{to}&textType=html"
    uri = URI(@@host + @@path + params)
    content = "[{\"Text\": \"#{text}\"}]"

    request = Net::HTTP::Post.new(uri)
    request['Content-type'] = 'application/json'
    request['Content-length'] = content.length
    request['Ocp-Apim-Subscription-Key'] = key
    request['X-ClientTraceId'] = SecureRandom.uuid
    request.body = content

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
    end

    result = response.body.force_encoding("utf-8")
    json = JSON.parse(result)
    json[0]["translations"][0]["text"]
  end
end
