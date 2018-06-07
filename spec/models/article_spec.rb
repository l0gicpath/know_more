require 'rails_helper'

RSpec.describe Article, type: :model do
  context 'Valid Records' do
    it "should create valid articles given valid details" do
      article = Article.new(title: "Valid Title", content: "Valid Content")
      expect(article.valid?).to be_truthy
    end

    it "should create valid articles with long titles" do
      title = "a" * 299
      article = Article.new(title: title, content: "Blah")
      expect(article.valid?).to be_truthy
    end

    it "should create valid articles with very short titles" do
      article = Article.new(title: "a", content: "b")
      expect(article.valid?).to be_truthy
    end
  end

  context 'Invalid Records' do
    it "should not create valid articles with super long titles" do
      article = Article.new(title: "a" * 301, content: "b")
      expect(article.valid?).to be_falsey
    end

    it "should not create valid articles missing a title" do
      article = Article.new(content: "Blah")
      expect(article.valid?).to be_falsey
    end

    it "should not create valid articles missing content" do
      article = Article.new(title: "Blah")
      expect(article.valid?).to be_falsey
    end
  end
end
