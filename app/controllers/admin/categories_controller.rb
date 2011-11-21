class Admin::CategoriesController < Admin::ApplicationController
  #Use "respond_to :html, :js" with create.js.erb will be work with respond_with.
  #The form_for must use ,:remote=>true.
  #Then all of the render will be as JS.
  #So redirect_to now will useless.
  #See more at http://lee2013.iteye.com/blog/1018349
  #respond_to :html, :js
  
  def index
    @categories = Category.where(["user_id = ?", session[:user_id]])
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])
    @category.user_id=session['user_id']
    if @category.save
      notice=t('create_succ',w: t('_category'))
    else
      notice=t('taken',w: @category.name)
#      respond_with @category
    end
    redirect_to admin_categories_path,notice: notice
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      redirect_to edit_admin_category_path, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categories_url,notice: t('delete_succ',w: t('_category'))
  end

  def show
    @category = Category.find(params[:id])
    
    respond_to do |format|
      format.html
    end
  end
end