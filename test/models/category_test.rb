require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new()
  end

  test "category should be valid" do 
    @category.name = "Sports"
    assert @category.valid?
  end

  test "name should be present" do
    @category.name = " "
    assert_not @category.valid?
  end

  test "name should be unique" do
    @category.name = "Kung-FU"
    @category.save
    @category2 = Category.new(name: "Kung-FU")
    assert_not @category2.valid?
  end

  test "name should be not too long" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end

  test "name should be not too short" do
    @category.name = "aa"
    assert_not @category.valid?
  end

end