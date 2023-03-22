RSpec::Matchers.define :require_authentication do
  match do |actual|
    expect(actual).to redirect_to \
      Rails.application.routes.url_helpers.new_user_session_path
  end

  failure_message do
    "expected to require login to access the method"
  end

  failure_message_when_negated do
    "expected not to require login to access the method"
  end

  description do
    "redirect to the login form"
  end
end
