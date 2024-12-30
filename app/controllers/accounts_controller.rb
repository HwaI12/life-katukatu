# app/controllers/accounts_controller.rb
class AccountsController < ApplicationController
  def create
    Rails.logger.debug "Params received: #{params.inspect}" # パラメータのログ

    new_account = {
      id: SecureRandom.uuid,
      name: params[:name],
      balance: params[:balance].to_f,
      account_type: params[:account_type]
    }
    
    Rails.logger.debug "New account created: #{new_account.inspect}" # 新規アカウントのログ
    
    session[:accounts] ||= []
    session[:accounts] << new_account
    
    Rails.logger.debug "Session after adding account: #{session[:accounts].inspect}" # セッション更新後のログ
    
    redirect_to root_path, notice: '所持金を追加しました'
  end

  def destroy
    session[:accounts].delete_if { |account| account[:id].to_s == params[:id].to_s }
    redirect_to root_path, notice: '所持金を削除しました'
  end
end