# payments api
class PaymentsController < ApplicationController
  def index
    @payments = Payment.filter(params.slice(:status, :price, :units, :payment_method,
                                            :create_after, :create_before))
    render json: @payments, status: 200
  end

  def show
    @payment = Payment.find(params[:id])
    render json: @payment, status: 200
  end
end
