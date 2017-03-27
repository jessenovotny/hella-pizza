class PizzasController < ApplicationController
  before_action :set_pizza, only: [:show, :edit, :update, :destroy]

  # GET /pizzas
  # GET /pizzas.json
  def index
    @pizzas = Pizza.all
  end

  # GET /pizzas/1
  # GET /pizzas/1.json
  def show
  end

  # GET /pizzas/new
  def new
    @pizza = Pizza.new
    @toppings = Topping.all
  end

  # GET /pizzas/1/edit
  def edit
    @toppings = Topping.all
  end

  # POST /pizzas
  # POST /pizzas.json
  def create
    @pizza = Pizza.new(pizza_params)

    # Toggle one or the other:
    # @pizza.update_toppings # update toppings based on description
    # @pizza.update_description # update desc based on toppings selected

    respond_to do |format|
      if @pizza.save
        format.html { redirect_to @pizza, notice: 'Pizza was successfully created.' }
        format.json { render :show, status: :created, location: @pizza }
      else
        format.html { render :new }
        format.json { render json: @pizza.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pizzas/1
  # PATCH/PUT /pizzas/1.json
  def update
    if @pizza
      @pizza.update(pizza_params)

      # Toggle one or the other:
      # @pizza.update_toppings # update toppings based on description
      # @pizza.update_description # update desc based on toppings selected

    elsif topping = Topping.find_by(id: params["topping_id"])
      @pizza = Pizza.find_by(id: params["pizza_id"])
      @pizza.toppings << topping unless @pizza.toppings.include?(topping)
      # @pizza.update_description # ENABLE to update desc based on toppings selected
    end
    respond_to do |format|
      if @pizza.save
        format.html { redirect_to @pizza, notice: 'Pizza was successfully updated.' }
        format.json { render :show, status: :ok, location: @pizza }
      else
        format.html { render :edit }
        format.json { render json: @pizza.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pizzas/1
  # DELETE /pizzas/1.json
  def destroy
    @pizza.destroy
    respond_to do |format|
      format.html { redirect_to pizzas_url, notice: 'Pizza was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pizza
      @pizza = Pizza.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pizza_params
      params.require(:pizza).permit(:name, :description, :toppings_attributes => [:name] , :topping_ids => [])
    end
end
