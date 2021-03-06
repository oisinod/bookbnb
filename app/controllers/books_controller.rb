class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    if params[:search].present?
      @books = Book.global_search(params[:search][:query])
    else
      @books = Book.all
    end

    @markers = @users.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        info_window:
        render_to_string(partial: "info_window", locals: { user: user }),
        image_url:
        helpers.asset_url("book_marker.png")
      }
    end
  end

  def show
    @bookings = @book.bookings
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update!(book_params)
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :description, :suggested_price, :photo)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
