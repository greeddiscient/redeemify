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

Given /the following vendor codes exist/ do |vendor_codes_table|
  vendor_codes_table.hashes.each do |code|
    v = Vendor.find_by_name(code['vendor'])
    v.vendorCodes.create!(:code => code["code"], :vendor => v)


  end
end

Given /I have already registered as an admin/ do
  AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
end

Given /I am signed in as an admin/ do
  fill_in("admin_user_email", :with => "admin@example.com")
  fill_in("admin_user_password", :with => "password")
  click_button("commit")
end

Given /the following provider codes exist/ do |provider_codes_table|
  p = Provider.create!(:name => 'Amazon', :provider => 'facebook', :email => 'amazon@amazon.com')
  provider_codes_table.hashes.each do |code|
    p.providerCodes.create!(:code => code["code"], :provider => p)
  end
end

Given /a provider "([^"]*)" exist$/ do |provider_name|
  p = Provider.create!(:name => provider_name, :provider => "facebook", :email => "amazon@amazon.com")
end

Given /I am signed in as a provider "([^"]*)"$/ do |provider_name|
  p = Provider.find_by_name(provider_name)
  name = p.name
  provider = p.provider
  email = p.email
  disable_test_omniauth()
  set_omniauth_provider(:name => name, :provider => provider, :email=> email)
  click_link("#{provider.downcase}-auth")
end

Given /the following vendors exist/ do |vendors_table|
  vendors_table.hashes.each do |vendor|
    Vendor.create(vendor)
  end
end

Given /^(?:|I )am on (.+)$/ do |page_name|
    visit path_to(page_name)
end

And /^I have updated the vendor profile/ do
  fill_in("cashValue", :with => "1")
  fill_in("expiration", :with => "11/11/2015")
  fill_in("description", :with => "description")
  fill_in("helpLink", :with => "www")
  fill_in("instruction", :with => "instruction")
  click_button("submit")
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
  set_omniauth_vendor(:name => name, :uid => uid, :provider => provider, :email=> 'test@gmail.com')
  click_link("#{provider.downcase}-auth")
end

Given /^a vendor "(.*?)" and user ID "(.*?)" registered with "(.*?)"$/ do |name, uid, provider|
  #@vendor1 = create(:vendor, :name => name, :uid => uid, :provider => provider)
  vendor = Vendor.new
  vendor.name = name
  vendor.uid = uid
  vendor.provider = provider
  vendor.email = 'test@gmail.com'
  vendor.cashValue = '1'
  vendor.save
end

And /^I have already registered with "([^"]*)" and provider code "([^"]*)"$/ do |provider, code|
  set_omniauth()
  click_link("#{provider.downcase}-auth")
  fill_in("code", :with => code)
  click_button("Submit")
  click_link("logout-link")
end


And /^I entered invalid credentials with "([^"]*)"$/ do |provider|
  set_invalid_omniauth()
  click_link("#{provider.downcase}-auth")
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
    click_link(link)
  end
end

When /^(?:|I )press "([^"]*)" button$/ do |button|
  click_button(button)
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  current_path.respond_to? :should
  current_path.should == path_to(page_name)
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

And /^I attach a file with vendor codes inside$/ do
  attach_file('file', File.join(Rails.root, 'features', 'upload-file', 'test.txt'))
end

And /^I attach a file with provider codes inside$/ do
  attach_file('file', File.join(Rails.root, 'features', 'upload-file', 'test.txt'))
end