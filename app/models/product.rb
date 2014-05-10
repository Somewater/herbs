require 'unidecoder'

class Product < ActiveRecord::Base

  belongs_to :section
  belongs_to :image, :class_name => 'Ckeditor::ProductPicture', :foreign_key => :image_1_id
  belongs_to :image_2, :class_name => 'Ckeditor::ProductPicture', :foreign_key => :image_2_id
  belongs_to :image_3, :class_name => 'Ckeditor::ProductPicture', :foreign_key => :image_3_id
  belongs_to :image_4, :class_name => 'Ckeditor::ProductPicture', :foreign_key => :image_4_id
  belongs_to :image_5, :class_name => 'Ckeditor::ProductPicture', :foreign_key => :image_5_id

  belongs_to :cost, :class_name => 'ProductCost', :foreign_key => :cost_1_id, :dependent => :destroy
  belongs_to :cost_2, :class_name => 'ProductCost', :foreign_key => :cost_2_id, :dependent => :destroy
  belongs_to :cost_3, :class_name => 'ProductCost', :foreign_key => :cost_3_id, :dependent => :destroy

  validates :name, :cost, :section, presence: true

  attr_accessible :section_id, :image_1_id, :image_2_id, :image_3_id, :image_4_id, :image_5_id, :name, :title_ru,
                  :description_ru, :cost_1_id, :cost_2_id, :cost_3_id, :short_description_ru

  scope :by_costs, ->(ids) { where('cost_1_id IN (?) OR cost_2_id IN (?) OR cost_3_id IN (?)', ids, ids, ids) }

  rails_admin do
    exclude_fields do |field_name|
      field_name.name.to_s.end_with? '_en'
    end
    edit do
      group :default do
        field :name
        field :title_ru
        field :short_description_ru do
          ckeditor false
        end
        field :description_ru do
          ckeditor true
        end
        field :section do
          associated_collection_scope do
            Proc.new { Section.find_by_name('herbs').children }
          end
        end
      end

      group :costs do
        field :cost
        field :cost_2
        field :cost_3
      end

      group :images do
        field :image
        field :image_2
        field :image_3
        field :image_4
        field :image_5
      end
    end
  end

  extend ::I18nColumns::Model
  i18n_columns :title, :description, :short_description

  def costs
    [cost, cost_2, cost_3].compact
  end

  def to_param
    self.name.to_s.size > 0 ? self.name : self.id
  end

  before_validation() do
    self.name = self.title.to_s.to_ascii.parameterize unless self.name.present?
  end

  def include_cost?(cost)
    cost = cost.id if cost.is_a?(ActiveRecord::Base)
    cost && (cost_1_id == cost || cost_2_id == cost || cost_3_id == cost)
  end

end