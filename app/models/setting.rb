class Setting < ActiveRecord::Base
  attr_accessible :key, :value, :description

  @cache = {}

  def self.[](key)
    @cache[key] ||= begin
      Setting.where(key: key).first.try(:value)
    end
  end

  def self.[]=(key, value)
    s = Setting.find_or_initialize_by_key(key)
    s.value = value
    s.save
    @cache.delete key
  end

  def self.reload
    @cache.clear
  end

  rails_admin do
    create do
      field :key
      field :value
      field :description
    end

    update do
      field :key do
        read_only true
      end
      field :value
      field :description
    end
  end
end
