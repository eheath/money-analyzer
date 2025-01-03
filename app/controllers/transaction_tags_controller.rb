class TransactionTagsController < ApplicationController
  def index
  end

  def new
    @user_transaction = current_user.user_transactions.find_by_id(params[:transaction_id])
  end

  def create
    tag_rule = nil
    tag = Tag.find_or_create_by(user_id: current_user.id, tag: params[:transaction_tag][:tag])
    if params[:search_string].present?
      tag_rule = TagRule.find_or_create_by(tag_id: tag.id, search_string: params[:search_string])
    end
    if tag_rule.present?
      current_user.tag_transactions(tag, tag_rule)
    else
      TransactionTag.create(user_transaction_id: params[:transaction_id], tag_id: tag.id)
    end
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end