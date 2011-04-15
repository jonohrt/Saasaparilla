module SpecHelpers
  def javascript(&block)
    Capybara.current_driver = :selenium
    yield
  ensure
    Capybara.use_default_driver
  end
end