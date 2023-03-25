module ApplicationHelper
  def navbar_title
    @game_room&.name || application_name
  end

  def application_name
    Rails.application.engine_name.gsub(/_application/, '').titleize
  end

  def icon(icon_style)
    tag.i class: icon_style
  end

  def link(content: '', url: '#', link_style: '', id: '', method: '', data: {})
    link_to url, class: link_style, method: method, id: id, data: data do
      content
    end
  end
  
  def button_text(enabled_text: '', disabled_text: 'Loading...', icon_style: 'fa-solid fa-spinner fa-spin')
    concat tag.span(enabled_text, class: 'show-when-enabled')
    tag.span(class: 'show-when-disabled') do
      concat disabled_text
      concat " "
      concat icon(icon_style)
    end
  end
end