
Given /^admin access token is set to "([^\"]*)"$/ do |access_token|
  APP_CONFIG[:access_token] = access_token
end

Then /^I should be signed in admin session$/ do
  controller.should be_admin
end

Then /^I should be signed out of admin session$/ do
  controller.should_not be_admin
end
