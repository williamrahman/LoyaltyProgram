# README

This is a project of ecommerce simulation customer loyalty program.
- The Loyalty consist of 3 tier which is bronze, silver, and gold tier
- The tier will be calculated based on the total order of the customer
- Total order will calculated from the beginning of previous year and Today
- The tier will be recalculated every order being made by the customer
- Every end of year, The tier will be resetted to previous level of tier
- If customer want to maintain their tier, they should has a minimum total order of the tier from this year until next year.

To install the App.
Things you may want to cover:
* Ruby installed
Ruby Version: 3.2.2
Rails Version: 7.1.1
* Postgresql installed
* Npm installed
Node.js Version 18.16.1
Npm Version 9.5.1

After git clone the app, you could do the step like this:
1. bundle install
2. rails db:create
3. rails db:migrate
4. rails db:seed
5. cd loyalty-program-views
6. npm install

Running the project
- BACKEND:
in the folder of root or "LoyaltyProgram" do the "rails s"
- FRONTEND:
go to loyalty-program-views folder and do "npm run dev"