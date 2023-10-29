require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "should upgrade tier from bronze to silver" do
    customer = customers(:bronze_customer)
    order = Order.create(customer: customer, total_order: 100)
    order.send(:check_current_tier)

    assert_equal "silver", customer.reload.tier
  end

  test "should upgrade tier from silver to gold" do
    customer = customers(:silver_customer)
    order = Order.create(customer: customer, total_order: 200)
    order.send(:check_current_tier)

    assert_equal "gold", customer.reload.tier
  end
end
