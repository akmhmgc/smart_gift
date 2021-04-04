class Dashboard::ProductsController < ApplicationController
  before_action :product_setup, only: %i[edit update destroy]
  before_action :authenticate_store!
  before_action :set_categories, only: %i[new create edit update]
  before_action :correct_store, only: %i[edit update destroy]
  
  def index
    @q = Product.where(store_id: current_store.id).with_attached_image.ransack(params[:q])
    @categories = Category.all
    @categories.each do |cat|
      cat.name.insert(0, '　') if cat.ancestry?
    end
    @products = @q.result.page(params[:page])
  end

  def new
    @product = current_store.products.build
  end

  def edit; end

  def update
    if @product.update(product_params)
      flash[:notice] = '変更されました'
      redirect_to dashboard_products_path
    else
      render 'edit'
    end
  end

  def create
    @product = current_store.products.build(product_params)
    if @product.save
      flash[:notice] = '作成できました'
      redirect_to dashboard_products_path
    else
      flash.now[:alert] = '作成に失敗しました。詳細はタイトル入力欄上のエラーメッセージをご確認ください。'
      render :new
    end
  end

  def destroy
    if @product.destroy
      redirect_to dashboard_products_path, notice: '削除に成功しました'
    else
      flash[:alert] = '削除に失敗しました。'
      redirect_back fallback_location: dashboard_products_path
    end
  end

  private

  def product_setup
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:image, :category_id, :name, :price, :description)
  end

  def set_categories
    @categories = Category.where.not(ancestry: nil)
  end

  # 正しい店舗かどうか確認
  def correct_store
    @product = Product.find(params[:id])
    return unless @product.store != current_store

    flash[:alert] = '無効なURLです'
    redirect_back(fallback_location: dashboard_products_path)
  end
end
