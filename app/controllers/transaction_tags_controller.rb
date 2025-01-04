class TransactionTagsController < ApplicationController
  def index
  end

  def new
    @user_transaction = current_user.user_transactions.find_by_id(params[:transaction_id])
    @tagged_untagged = params[:tagged_untagged]
  end

  def create
    @tagged_untagged = params[:tagged_untagged]
    @tag_rule = nil

    @user_transactions = if params[:tagged_untagged] == 'tagged'
      current_user.user_transactions.tagged
    elsif params[:tagged_untagged] == 'untagged'
      current_user.user_transactions.untagged
    else
      current_user.user_transactions
    end

    @tag = Tag.find_or_create_by(user_id: current_user.id, tag: params[:transaction_tag][:tag])
    if params[:search_string].present? && @tag.persisted?
      @tag_rule = TagRule.find_or_create_by(tag_id: @tag.id, search_string: params[:search_string])
    end

    if @tag_rule.present? && @tag_rule.persisted?
      @tag_rule.apply
    elsif @tag.persisted? && @tag.valid?
      @transaction_tag = TransactionTag.create(user_transaction_id: params[:transaction_id], tag_id: @tag.id)
    end
    # create_notice
    if @tag.persisted? && @tag.valid?
      respond_to do |format|
        format.html
        format.turbo_stream
      end
    else
      @user_transaction = current_user.user_transactions.find_by_id(params[:transaction_id])
      render :new, status: :unprocessable_entity
    end
  end
end