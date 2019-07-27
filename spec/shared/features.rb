module Features
  def delete_item
    click_link 'Destroy'
    confirm = page.driver.browser.switch_to.alert
    assert_equal confirm.text, "Are you sure?"
    confirm.accept
  end
end