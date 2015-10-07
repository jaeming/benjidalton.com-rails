class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  after_create :title_safe_slugs
  before_save :convert_to_html
  validates :title, presence: true,
                    length: {minimum: 5}
  validates :text, presence: true,
                   length: {minimum: 20}

  def convert_to_html
    html = markdown(self.text)
    self.text = html
  end

  def title_safe_slugs
    self.slug = self.title.parameterize
    self.save
  end

  private
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render text).html_safe
  end
end
