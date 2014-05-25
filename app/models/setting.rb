class Setting < ActiveRecord::Base
  attr_accessible :key, :value, :description

  def self.[](key)
    Setting.where(key: key).first
  end

  def self.[]=(key, value)
    s = Setting.find_or_initialize_by_key(key)
    s.value = value
    s.save
  end

  rails_admin do
    edit do
      field :key do
      end
      field :value
      field :description
    end
  end
end
