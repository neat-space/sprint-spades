# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :request do
  describe "GET /" do
    it "is successful" do
      get root_path
      expect(response).to be_successful
    end
  end
end