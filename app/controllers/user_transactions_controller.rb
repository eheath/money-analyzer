class UserTransactionsController < ApplicationController
  def index
    @user_transactions = if params[:tagged_untagged] == 'tagged'
      current_user.user_transactions.tagged
    elsif params[:tagged_untagged] == 'untagged'
      current_user.user_transactions.untagged
    else
      current_user.user_transactions
    end
  end
end
