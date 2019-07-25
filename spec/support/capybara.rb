Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :chrome

Capybara.configure do |config|
  config.default_max_wait_time = 10 # seconds
  config.default_driver        = :selenium
end

RSpec.configure do |config|
  config.before(:each, type: :feature) do
    Capybara.current_session.driver.browser.manage.window.resize_to(1024, 768)
  end
end