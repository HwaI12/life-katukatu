# app/controllers/expenses_controller.rb
class ExpensesController < ApplicationController
  def index
    @expenses = session[:expenses]
    @accounts = session[:accounts]
    @total_balance = calculate_total_balance
    @can_survive = can_survive?
    
    # デバッグ用
    Rails.logger.debug "Session expenses: #{session[:expenses].inspect}"
    Rails.logger.debug "Session accounts: #{session[:accounts].inspect}"
  end

  def create
    Rails.logger.debug "Params received: #{params.inspect}" # パラメータのログ

    new_expense = {
      id: SecureRandom.uuid,
      title: params[:title],
      amount: params[:amount].to_f,
      expense_date: params[:expense_date],
      category: params[:category],
      description: params[:description]
    }
    
    Rails.logger.debug "New expense created: #{new_expense.inspect}" # 新規出費のログ
    
    session[:expenses] ||= []
    session[:expenses] << new_expense
    
    Rails.logger.debug "Session after adding expense: #{session[:expenses].inspect}" # セッション更新後のログ
    
    redirect_to root_path, notice: '出費を記録しました'
  end

  def destroy
    session[:expenses].delete_if { |expense| expense[:id].to_s == params[:id].to_s }
    redirect_to root_path, notice: '出費を削除しました'
  end

  def reset
    session[:expenses] = []
    session[:accounts] = []
    redirect_to root_path, notice: 'データをリセットしました'
  end

  private

  def calculate_total_balance
    # 所持金の合計を計算
    total_accounts = (session[:accounts] || []).sum do |account|
      account["balance"].to_f  # ストリングキーを使用し、明示的に数値に変換
    end

    # 支出の合計を計算
    total_expenses = (session[:expenses] || []).sum do |expense|
      expense["amount"].to_f  # ストリングキーを使用し、明示的に数値に変換
    end

    # デバッグ用ログ出力
    Rails.logger.debug "Total accounts: #{total_accounts}"
    Rails.logger.debug "Total expenses: #{total_expenses}"
    Rails.logger.debug "Balance: #{total_accounts - total_expenses}"

    total_accounts - total_expenses
  end

  def can_survive?
    calculate_total_balance >= 0
  end
end