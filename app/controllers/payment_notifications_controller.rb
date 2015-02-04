class PaymentNotificationsController < ApplicationController
  
  # railscast way , does not work here: protect_from_forgery :except => [:create]
  # following way sucessfully skips authenticity for create here
  # so that paypal can post ...
  skip_before_filter :verify_authenticity_token, :only => :create
  skip_before_filter :authorize, :only => [:index, :show, :new, :create, :edit, :update]
 
  def create
    #begin
    #    c=Cart.find( params[:invoice] )

    #allways save the notification
    #flag invalid cart_id (params invoice ) in the model!
    PaymentNotification.create!( :params=>params, 
                                     :order_id=>params[:invoice], 
                                     :status=>params[:payment_status], 
                                     :transaction_id=>params[:txn_id]
                               )
    render :text=>"ok"
    #rescue ActiveRecord::RecordNotFound
    #  render :nothing=>:true
    #end

   end
end


   #@payment_notification = PaymentNotification.new(params[:payment_notification])
    #if @payment_notification.save
    #  flash[:notice] = "Successfully created payment notification."
    #  redirect_to root_url
    #else
    #  render :action => 'new'
    #end


