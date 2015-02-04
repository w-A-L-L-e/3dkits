class ProductsController < ApplicationController

  before_filter :authenticate_login!, :except=>[:index, :show, :buy, :pay]
  skip_before_filter :authorize, :only=>[:index,:show, :buy, :pay] #no login or permission checks for downloading (it's with a md5 hash)


  #include ActionController::MimeResponds
  #include ActionController::RespondWith
 
  respond_to :html, :json, :js


  #paymill transaction here...
  def buy
    @product = Product.find( params[:id] )
  end

  def pay
    begin
      require "paymill"
      @product = Product.find( params[:id] )
 
      #use these keys
      #APP_CONFIG[:payment][:private_key]
      #APP_CONFIG[:payment][:public_key]
      Paymill.api_key = APP_CONFIG[:payment][:private_key]
      
      #Actual payment transaction from paymill here!
      transaction = Paymill::Transaction.create(  amount: (params[:amount].to_f*100).to_i,
                                    currency:    "EUR",
                                    description: "3D kit: #{@product.id}",
                                    token:       params[:paymillToken] )

      #example 
      #<Paymill::Transaction:0x007fbe2d63a4c8 @description="3D kits payment", @livemode=false, @invoices=[], @short_id=nil, @updated_at=2013-08-26 17:01:23 +0200, @status="closed", @origin_amount=69900, @client={"id"=>"client_e4fb7f288afc4912e864", "email"=>nil, "description"=>nil, "created_at"=>1377529283, "updated_at"=>1377529283, "app_id"=>nil, "payment"=>[], "subscription"=>nil}, @preauthorization=nil, @response_code=20000, @app_id=nil, @payment={"id"=>"pay_0da0e530efeaf532e5f2d87f", "type"=>"creditcard", "client"=>"client_e4fb7f288afc4912e864", "card_type"=>"visa", "country"=>nil, "expire_month"=>"12", "expire_year"=>"2015", "card_holder"=>"Water Schreppers", "last4"=>"1111", "created_at"=>1377529281, "updated_at"=>1377529283, "app_id"=>nil}, @amount="69900", @is_fraud=false, @refunds=nil, @fees=[], @id="tran_7d1a9c12f4ee737a23bd2fcbb69e", @created_at=2013-08-26 17:01:23 +0200, @currency="EUR">

      @payment_transaction = PaymentTransaction.create( 
                                                :description  => transaction.description ,
                                                #:amount       => transaction.origin_amount,
                                                :client       => transaction.client,
                                                #:client_email => transaction.email,
                                                :payment      => transaction.payment,
                                                :paymill_hash => transaction.to_yaml
                                            )

  
      #logger.info( trans.inspect )

    rescue Paymill::APIError
      @payment_transaction = nil
    end
  end

  # GET /products
  # GET /products.json
  def index
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product]) #investigate strong params here!!!!
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def product_params
      params.require(:product).permit(:description, :name, :price)
    end
end
