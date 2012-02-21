class BackendsController < ApplicationController
  include ActiveMerchant::Billing::Integrations
  protect_from_forgery :except=>[:worldpay_return]
  
# Sample Response from World Pay
# FILTER is where I removed my own test details.
# {"region"=>"", "authAmountString"=>"US&#36;1.00", "_SP.charEnc"=>"UTF-8", "desc"=>"", "tel"=>"", "address1"=>"Long Road", "countryMatch"=>"Y", "cartId"=>"4", "address2"=>"", "address3"=>"", "lang"=>"en", "callbackPW"=>"", "rawAuthCode"=>"A", "transStatus"=>"Y", "amountString"=>"US&#36;1.00", "authCost"=>"1.00", "currency"=>"USD", "installation"=>"[FILTER]", "amount"=>"1.00", "countryString"=>"Singapore", "displayAddress"=>"[filter]", "transTime"=>"1329827821950", "name"=>"Rocks", "testMode"=>"100", "routeKey"=>"ECMC-SSL", "ipAddress"=>"[FILTER]", "fax"=>"", "rawAuthMessage"=>"cardbe.msg.authorised", "instId"=>"[FILTER]", "AVS"=>"0112", "compName"=>"MERCHANT WP AP INTERNAL Test Account", "authAmount"=>"1.00", "postcode"=>"", "cardType"=>"MasterCard", "cost"=>"1.00", "authCurrency"=>"USD", "country"=>"SG", "charenc"=>"UTF-8", "email"=>"john@example.com", "address"=>"example road", "transId"=>"128681018", "msgType"=>"authResult", "town"=>"sg", "authMode"=>"A"}
  
  def worldpay_return
    notification = WorldPay::Notification.new(request.raw_post)  
    
    order = Order.find(notification.item_id)

    if notification.acknowledge
      begin
        if notification.complete?
          order.status = 'success'
        end
      rescue
        order.status = "failed"
        raise
      ensure
        order.save
      end
    end
  render :text =>"Order status for #{order.id} is #{order.status}" 
    
  end
  
end
