module NavigationHelper
  def login_helper(style = 'nav-link nav-link nav-link-icon')
    if user_signed_in?
      nav_helper(ul_style: 'navbar-nav bd-navbar-nav flex-row', li_style: 'nav-item dropdown', link_style: style, items: auth_nav_items)
    else
      profile_navs_helper(style)
    end
  end

  def nav_helper(ul_style: '', li_style: '', link_style: '', items: nav_items)
    tag.ul(class: ul_style) do
      items.each do |item|
        concat tag.li(link_to(item[:title], item[:url], class: "#{link_style} #{active? item[:url]}"), class: li_style)
      end
    end
  end

  def active?(path)
    "active" if current_page? path
  end

  private

  def nav_items
    [{ url: root_path, title: "Game Room" }, { url: root_path, title: "Issues" }]
  end

  def auth_nav_items
    [{ url: new_user_registration_path, title: 'Register' }, { url: new_user_session_path, title: 'Login' }]
  end

  def profile_navs_helper(style)
    tag.li(class: 'nav-item dropdown') do
      concat link(content: icon("ni ni-settings-gear-65"), link_style: style, data: { bs_toggle: "dropdown" })
      concat tag.div(
        link_to('Logout', destroy_user_session_path, method: :delete, class: "dropdown-item"), class: "dropdown-menu dropdown-menu-right dropdown-menu-end"
      )
    end
  end
end
