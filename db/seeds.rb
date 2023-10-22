# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
ActiveRecord::Base.transaction do
    Customer.create!([
        {name: "William Rahman"},
        {name: "William"},
        {name: "Rahman"},
        {name: "Willy"}
    ])

    Order.create!([
        {customer: Customer.first, total_order: 100},
        {customer: Customer.first, total_order: 200, created_at: DateTime.now.prev_year.beginning_of_year},
        {customer: Customer.first, total_order: 300, created_at: DateTime.now.prev_year.beginning_of_year},
        {customer: Customer.find(2), total_order: 100},
        {customer: Customer.find(2), total_order: 50, created_at: DateTime.now.prev_year.beginning_of_year},
        {customer: Customer.find(3), total_order: 50},
        {customer: Customer.last, total_order: 0},
    ])

    Customer.all.each do |customer|
        customer.send(:check_current_tier)
        customer.send(:maintain_total_spent)
    end
end