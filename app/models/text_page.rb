class TextPage < ActiveRecord::Base

  extend ::I18nColumns::Model
  i18n_columns :title, :body, :ferret => true

  attr_accessible :name, :section_id
  belongs_to :section

  validates :section, :presence => true
  validates :name, :format => /^[a-z][a-z0-9\-]+$/

  rails_admin do
    exclude_fields do |field_name|
      field_name.name.to_s.end_with? '_en'
    end

    edit do
      field :name
      field :section
      field :title_ru
      field :body_ru do
        ckeditor true
      end
    end
  end

  def title
    t = super
    t = self.name if t.blank?
    t
  end

  def to_param
    self.name.to_s.size > 0 ? self.name : self.id
  end
end
