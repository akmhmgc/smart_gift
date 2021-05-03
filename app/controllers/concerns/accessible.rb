module Accessible
  extend ActiveSupport::Concern
  included do
    prepend_before_action :check_user
  end

  protected

  def check_user
    if current_store
      flash[:notice] = '店舗として既にログインしています。'
      redirect_to(store_root_path) and return
    elsif current_user
      flash[:notice] = 'ユーザーとして既にログインしています。'
      redirect_to(root_path)
    end
  end
end
