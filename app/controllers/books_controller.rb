class BooksController < ApplicationController
  before_action :logged_in_user, only: [:new, :edit]
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :categories_select_tag, only: [:new, :edit]

  def index
    @categories = Category.all.pluck(:name, :id).insert(0, ["All", 'all'])
    category = Category.find_by id: params[:category_id]
    @books = Book.at_category(category)
    @books = @books.title_like(params[:title]).author_like(params[:author])
    @books = @books.paginate page: params[:page], per_page: 50
  end

  def new
    @book = Book.new
    @picture = @book.pictures.build
  end

  def create
    @book = Book.new book_params
    if @book.save
      params[:picture_uploads].each do |p|
        @picture = @book.pictures.create!(picture: p, book_id: @book.id)
      end
      redirect_to @book
    else
      render action: 'new'
    end
  end

  def edit
    @book = Book.find params[:id]
    @pictures = @book.pictures
  end

  def update
    @book = Book.find params[:id]
    if @book.update_attributes book_params
      if params[:picture_uploads]
        @book.pictures.delete_all
        params[:picture_uploads].each do |p|
          @picture = @book.pictures.create!(picture: p, book_id: @book.id)
        end
      end
      flash[:success] = "Book updated"
      redirect_to books_path
    else
      render 'edit'
    end
  end

  def show
    @book = Book.find params[:id]
    @readstatus = ReadStatus.latest current_user.id, @book.id
    @status = @readstatus.first.status if @readstatus.present?
    @pictures = @book.pictures
  end

  def destroy
    @book = Book.find params[:id]
    @book.destroy
    flash[:success] = "Book deleted"
    redirect_to request.referrer || root_url
  end

  private

  def book_params
    params.require(:book).permit :title, :author, :document, :category_ids, :publish_date, :number_of_page,
      pictures_attributes: [:id, :book_id, :picture]
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def categories_select_tag
    @categories = Category.all.map{|c| [c.name, c.id]}
  end

end
