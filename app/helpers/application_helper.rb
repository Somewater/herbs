# encoding: utf-8

module ApplicationHelper

  FIELD_TO_RUSSIAN_NAME = {name: 'Имя', phone: 'Телефон', email: 'Email', address: 'Адрес'}

  def each_with_borders(array, &block)
    last_index = array.size - 1
    index = 0
    array.each do |item|
      block.call(item, index, index == last_index)
      index += 1
    end
  end

  def section_path(id)
    if(id.to_s == Section::MAIN_NAME || (id.is_a?(Section) && id.main?))
      '/'
    else
      super
    end
  end

  def url_for_params(params)
    url_for(params.merge(params))
  end
  
  def human_file_size(bytes, options = {})
	 [bytes.to_f / 1_048_576, 0.01].max.round(2).to_s + ' ' + I18n.t('megabyte')
  end

  def sitemap_html(section)
    result = "<a href='" + section_path(section) + "'>" + section.title + "</a>"
    children = section.children
    unless children.blank?
      result << "<ul>"
      children.each do |child|
        result << "<li>"
        result << sitemap_html(child)
        result << "</li>"
      end
      result << "</ul>"
    end
    result
  end

  def to_russian_errors(errors)
    "Возникли ошибки: " <<
      errors.messages.map{|field, msgs| "#{FIELD_TO_RUSSIAN_NAME[field.to_sym]} #{msgs.join(', ')}" }.join(', ')
  end
end
