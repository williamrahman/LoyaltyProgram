class CustomersController < ApplicationController
  before_action :set_customer, only: %i[ show update destroy ]

  # GET /customers
  def index
    @customers = Customer.all

    @response = @customers.sort.map{|customer| {
      id: customer.id,
      name: customer.name,
      total_spent: customer.current_tier_total_spent,
      tier: customer.tier&.capitalize,
    }}
      
    render json: @response
  end

  # GET /customers/1
  def show
    @customer = Customer.find(params[:id])
    @response = {
      id: @customer.id,
      customer_name: @customer.name,
      tier: @customer.tier&.capitalize,
      date_of_current_tier_trx: DateTime.now.prev_year.beginning_of_year,
      current_tier_total_spent: @customer.current_tier_total_spent,
      next_tier: @customer.next_tier,
      total_spent_need_to_upgrade: @customer.upgrade_tier_total_spent_left,
      before_tier: @customer.tier_before,
      total_spent_to_maintain_current_tier: @customer.maintain_current_tier,
      reset_tier_date: DateTime.now.next_year.beginning_of_year,
      progress_to_reach_next_tier: progress_bar(@customer),
      orders: @customer.orders
    }
    render json: @response
  end

  def current_order_history
    @customer = Customer.find(params[:id])
    @orders = @customer.orders.where('created_at BETWEEN ? AND ?', DateTime.now.prev_year.beginning_of_year, DateTime.now)
    
    render json: @orders
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      render json: @customer, status: :created, location: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customers/1
  def update
    if @customer.update(customer_params)
      render json: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /customers/1
  def destroy
    @customer.orders.destroy_all
    @customer.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.require(:customer).permit(:name, :total_spent, :tier)
    end

    def progress_bar(customer)
      if customer.silver? 
        1 - customer.upgrade_tier_total_spent_left.to_f/400
      elsif customer.bronze?
        1 - customer.upgrade_tier_total_spent_left.to_f/100
      else
        1
      end
    end
end
