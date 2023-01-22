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
end
