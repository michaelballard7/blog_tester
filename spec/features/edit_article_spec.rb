require 'rails_helper'

RSpec.feature "Editing an article" do

  before do
    pablo = User.create(email:"pablo@example.com", password: "password")
    login_as(pablo)
    @article = Article.create(title: "Title One", body: "Body of article one", user: pablo)
  end

  scenario "A user updates an article" do
    visit '/'

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: "Updated Title"
    fill_in "Body", with: "Updated Body of Article"
    click_button "Updated Article"

    expect(page).to have_content("Article has been updated")
    expect(page.current_path).to eq(article_path(@article))
  end

  scenario "A user fail to update an article" do
    visit '/'

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: ""
    fill_in "Body", with: "Updated Body of Article"
    click_button "Updated Article"

    expect(page).to have_content("Article has not been updated")
    expect(page.current_path).to eq(article_path(@article))
  end
end
