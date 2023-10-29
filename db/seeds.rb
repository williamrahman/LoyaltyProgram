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
        {name: "Willy"},
        {name: "Customer 1"},
        {name: "Customer 2"},
        {name: "Customer 3"},
        {name: "Customer 4"},
        {name: "Customer 5"},
        {name: "Customer 6"},
        {name: "Customer 7"},
        {name: "Customer 8"},
        {name: "Customer 9"},
        {name: "Customer 10"},
        {name: "Customer 11"},
    ])

    Order.create!([
        {customer: Customer.first, total_order: 100},
        {customer: Customer.first, total_order: 200, created_at: DateTime.now.prev_year.beginning_of_year},
        {customer: Customer.first, total_order: 300, created_at: DateTime.now.prev_year.beginning_of_year},
        {customer: Customer.find(2), total_order: 100},
        {customer: Customer.find(2), total_order: 50, created_at: DateTime.now.prev_year.beginning_of_year},
        {customer: Customer.find(3), total_order: 50},
        {customer: Customer.find(4), total_order: 50},
        {customer: Customer.find(5), total_order: 37},
        {customer: Customer.find(5), total_order: 13},
        {customer: Customer.find(5), total_order: 23},
        {customer: Customer.find(6), total_order: 91},
        {customer: Customer.find(8), total_order: 87},
        {customer: Customer.find(9), total_order: 121},
        {customer: Customer.find(10), total_order: 553},
        {customer: Customer.find(11), total_order: 102},
        {customer: Customer.find(12), total_order: 77},
        {customer: Customer.find(13), total_order: 56},
        {customer: Customer.find(13), total_order: 23},
        {customer: Customer.find(14), total_order: 11},
        {customer: Customer.find(15), total_order: 105},
        {customer: Customer.last, total_order: 100},
    ])
end