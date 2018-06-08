require 'rails_helper'

RSpec.describe Translator::Services::Microsoft do

  context "Verify configurations" do
    it "raises MissingConfiguration when passed no configuration" do
      expect {
        Translator::Services::Microsoft.new(nil)
      }.to raise_error(Translator::Error::MissingConfiguration)
    end

    it "raises Missingconfiguration when passed wrong configuration" do
      expect {
        Translator::Services::Microsoft.new({})
      }.to raise_error(Translator::Error::MissingConfiguration)
    end
  end


  context "Translations" do
    subject { Translator::Services::Microsoft.new({"key" => "a-key"}) }

    it "raises ServiceError if service response was not 2xx" do
      stub_failed_microsoft_request

      expect {
        subject.translate("Text", :de, :html)
      }.to raise_error(Translator::Error::ServiceError)
    end

    it "should give translated text back if service response was 2xx" do
      stub_successful_microsoft_request

      expect {
        subject.translate("Hello World!", :de, :html)
      }.to_not raise_error

      expect(subject.translate("Hello World!", :de, :html)).to eq("Hallo Welt!")
    end
  end
end
