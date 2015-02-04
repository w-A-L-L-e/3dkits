class PaymentsController < ApplicationController 

  require 'overschrijving_mededeling.rb'

  def generateMededeling( betaler )
    if BetalingNummer.count<1
      nummer = '1235522342'
      b=BetalingNummer.new( :volgnummer=>nummer )
      b.save
    else
      lastnum = BetalingNummer.last.volgnummer
      nummer=(lastnum.to_i+1).to_s
      b=BetalingNummer.new( :volgnummer=>nummer )
      b.save
    end

    code = OverschrijvingMededeling.new( nummer ).mededeling
  end

  def bancontact_winnaar
    @winnaar = Winnaar.find( params[:id] )

    if @winnaar && @winnaar.betaling=="PayPal"
      @winnaar.betaling = generateMededeling( @winnaar )
      @winnaar.save
      if @winnaar.save
        flash.now[:notice]="Betalingsmethode opgeslagen. We sturen de overschrijvingsgegevens ook per email"
        # todo send mededeling email!
        UserMailer.winnaar_bancontact(@winnaar).deliver unless @winnaar.user.email.blank?
      else
        flash.now[:error]="Betaling kon niet verwerkt worden."
      end
    else
      flash.now[:notice]="Bekijk uw email we hebben deze gegevens reeds per email verzonden"
    end
  end

  def bancontact_koper
    @koper = Koper.find( params[:id] )
    
    if @koper && @koper.betaling=="PayPal"
      @koper.betaling = generateMededeling( @koper )
      if @koper.save
        flash.now[:notice]="Betalingsmethode opgeslagen. We sturen de overschrijvingsgegevens ook per email"
        # todo send mededeling email!
        UserMailer.koper_bancontact(@koper).deliver unless @koper.user.email.blank?
      else
        flash.now[:error]="Betaling kon niet verwerkt worden."
      end
    else
      flash.now[:notice]="Bekijk uw email we hebben deze gegevens reeds per email verzonden"
    end
  end

end


