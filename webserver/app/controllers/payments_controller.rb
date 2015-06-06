# payments api
class PaymentsController < ApplicationController
  def index
    @payments = Payment.filter(params.slice(:status, :price, :units, :payment_method,
                                            :create_after, :create_before))
    render json: @payments, root: false ,status: 200
  end

  def show
    @payment = Payment.find(params[:id])
    render json: @payment, root: false ,status: 200
  end
end
