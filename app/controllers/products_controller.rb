class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create]

  # GET /products
  # GET /products.json
  def index
    @products = Product.where(enable: true)
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end


# Boton comprar
  def comprar
    @product = Product.find(params[:id])
    @product.enable = false
    @product.save
    redirect_to root_path, notice: 'Producto comprado'
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  #Método perfil
  def profile
    @user = User.find(params[:id])
  end

#Método ventas
  def ventas
    @products = Product.where(user_id: current_user.id)
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'El producto fue creado' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'El producto fue actualizado' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'El producto fue eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :photo, :price, :enable)
    end
end
