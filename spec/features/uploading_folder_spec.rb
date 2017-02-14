require "rails_helper"

RSpec.feature "uploading directory" do
  scenario "A user upload a directory" do
    visit "/"
    attach_file "upload", Rails.root + 'spec/fixtures/acoj.zip'
    click_button "Create Repository"
  end
end
