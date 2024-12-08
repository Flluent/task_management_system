require 'rails_helper'

RSpec.describe "users/index.html.erb", type: :view do
  it "displays all users" do
    user = User.create(username: "testuser", password: "password", password_confirmation: "password")
    assign(:users, [ user ])

    render

    expect(rendered).to include("Все пользователи")
    expect(rendered).to include("testuser")
  end
end
