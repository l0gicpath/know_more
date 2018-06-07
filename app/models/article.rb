class Article < ApplicationRecord
  validates :title, presence: true, length: { in: 1..300 }
  validates :content, presence: true

  before_save :translate_to_german
  before_update :translate_to_german


  def translate_to_german
    self.gr_content = MsTranslator.translate(self.content, "de")
  end
end
