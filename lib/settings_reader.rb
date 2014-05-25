class SettingsReader
  def self.read(file = nil)
    file ||= File.join(Rails.root, 'config', 'settings.yml')
    parse_settings(YAML.load(File.open(file).read))
  end

  def self.parse_settings(x, prefix = '', output = {})
    if x.is_a?(Hash) && !(x.size <= 2 && x['value'])
      if (not prefix.empty?)
        prefix += "."
      end
      x.each {|key, value|
        parse_settings(value, prefix + key.to_s, output)
      }
    else
      output[prefix] = x
    end
    output
  end
end