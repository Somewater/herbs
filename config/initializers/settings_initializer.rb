settings = SettingsReader.read
existed = Setting.select(:key).where(key: settings.keys).map(&:key).to_set
settings.each do |key, data|
  next if existed.include? key
  Setting.create(key: key, value: data["value"], description: data["description"] || data["desc"])
end