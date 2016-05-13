class TransactionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def create
    transaction.checkin if transaction_params.any?
    render status: status, json: message.to_json
  end

  private

  def status
    case transaction.state_name
    when :failed
      400
    else
      200
    end
  end

  def message
    case transaction.state_name
    when :failed
      { error: 'Something went wrong with the checkin.' }
    when :checked_in
      { success: 'Transaction successfully checked in!' }
    else
      { success: 'Transaction successfully processed (no checkin required).' }
    end
  end

  def transaction
    @transaction ||= Transaction.create_from_api(transaction_params)
  end

  def transaction_params
    params.require(:data)
  end
end
