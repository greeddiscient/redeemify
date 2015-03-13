require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))
#require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "omniauth"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

Then /^show me the page$/ do
  save_and_open_page
end

Given /^(?:|I )am on (.+)$/ do |page_name|
    visit path_to(page_name)
end

And /^(?:|I )have never registered$/ do
  disable_test_omniauth()
end

Given /^I am signed in with "([^"]*)"$/ do |provider|
  set_omniauth()
  click_link("#{provider.downcase}-auth")
end

Given /^I am signed in as a vendor "([^"]*)" and user ID "([^"]*)" with "([^"]*)"$/ do |name, uid, provider|
  disable_test_omniauth()
  set_omniauth_vendor(:name => name, :uid => uid, :provider => provider)
  click_link("#{provider.downcase}-auth")
end

Given /^a vendor "(.*?)" and user ID "(.*?)" registered with "(.*?)"$/ do |name, uid, provider|
  #@vendor1 = create(:vendor, :name => name, :uid => uid, :provider => provider)
  vendor = Vendor.new
  vendor.name = name
  vendor.uid = uid
  vendor.provider = provider
  vendor.save
end

And /^I have already registered with "([^"]*)"$/ do |provider|
  set_omniauth()
  click_link("#{provider.downcase}-auth")
  fill_in("code", :with => "9283084")
  click_button("Submit")
  click_link("logout-link")
end

Given /^(?:|I )can see "([^"]*)"$/ do |words|
  if page.respond_to? :should
    page.should have_content(words)
  else
    assert page.has_content?(text)
  end
end

When /^(?:|I )press "([^"]*)" link$/ do |link|
  if link.eql? "Log out"
    click_link("logout-link")
  else
    visit '/auth/:link'
  end
end

When /^(?:|I )press "([^"]*)" button$/ do |button|
  click_button(button)
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path

  login = false
  if page_name.include? "login"
    login = true
  end

  if login
    text = page_name.split(" ")
    third_party = text[1].strip
    if current_path.respond_to? :should
      current_url.should include(third_party)
    else
      assert current_path.include?(third_party), "Not on correct login page."
    end
  else
    if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
  end
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end
