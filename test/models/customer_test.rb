require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  test "should set default tier to bronze" do
    customer = Customer.new
    assert_equal "bronze", customer.tier
  end

  test "total history orders" do
    customer = customers(:bronze_customer)
    assert_equal 50, customer.total_history_orders
  end

  test "should maintain tier when total spent is below upgrade threshold" do
    customer = customers(:silver_customer)
    customer.update(total_spent: 300)
    assert_equal "silver", customer.reload.tier
  end

  test "should calculate total spent for current tier" do
    customer = customers(:silver_customer)
    assert_equal 300, customer.current_tier_total_spent
  end

  test "should calculate total spent for current year" do
    customer = customers(:silver_customer)
    assert_equal 300, customer.current_year_total_spent
  end

  test "should calculate amount needed to upgrade tier from bronze" do
    customer = customers(:bronze_customer)
    assert_equal 50, customer.upgrade_tier_total_spent_left
  end

  test "should calculate amount needed to upgrade tier from silver" do
    customer = customers(:silver_customer)
    assert_equal 200, customer.upgrade_tier_total_spent_left
  end

  test "should get next tier" do
    customer = customers(:bronze_customer)
    assert_equal "SILVER", customer.next_tier
  end

  test "should get tier before" do
    customer = customers(:gold_customer)
    assert_equal "SILVER", customer.tier_before
  end

  test "should get next tier for silver" do
    customer = customers(:silver_customer)
    assert_equal "GOLD", customer.next_tier
  end

  test "should get tier before for silver" do
    customer = customers(:silver_customer)
    assert_equal "BRONZE", customer.tier_before
  end
end
