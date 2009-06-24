
Given /^admin access token is set to "([^\"]*)"$/ do |access_token|
  APP_CONFIG[:access_token] = access_token
end

Given /^I signed in admin session$/ do
  Given %{admin access token is set to "access-token"}
  And %{I am on the auth page}
  And %{I fill in "Access Token" with "access-token"}
  And %{I press "Auth!"}
end

Given /^I signed out of admin session$/ do
  # seems it's ok to leave body blank
end

Then /^I should be signed in admin session$/ do
  controller.should be_admin
end

Then /^I should be signed out of admin session$/ do
  controller.should_not be_admin
end
