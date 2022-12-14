require 'rails_helper'
require_relative '../support/factory_bot'
require_relative '../support/controller_macros'

RSpec.feature "Projects", type: :feature do
  before(:each) do
    user = FactoryBot.create(:user)
    sign_in user
  end
  context "Create new project" do
    before(:each) do
      visit new_project_path
      within("form") do
        fill_in "Title", with: "Test title"
      end
    end

    scenario "should be successful" do
      fill_in "Description", with: "Test description"
      click_button "Create Project"
      expect(page).to have_content("Project was successfully created")
    end

    scenario "should fail" do
      click_button "Create Project"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "Update project" do
    let(:project) { Project.create(title: "Test title", description: "Test content") }
    before(:each) do
      visit edit_project_path(project)
    end

    scenario "should be successful" do
      within("form") do
        fill_in "Description", with: "New description content"
      end
      click_button "Update Project"
      expect(page).to have_content("Project was successfully updated")
    end

    scenario "should fail" do
      within("form") do
        fill_in "Description", with: ""
      end
      click_button "Update Project"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "Remove existing project" do
    scenario "remove project" do
    visit new_project_path
    fill_in "Description", with: "Test description"
    fill_in "Title", with: "Test title"
    click_button "Create Project"
    click_button "Destroy this project"
    expect(page).to have_content("Project was successfully destroyed")
    expect(Project.count).to eq(0)
    end
  end
end