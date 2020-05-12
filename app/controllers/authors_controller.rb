class AuthorsController < ApplicationController
  before_action :require_user
  before_action :logged_in, only: %i[index show new edit]
  before_action :set_author, only: %i[show edit update destroy]

  def index
    @authors = Author.all
  end

  def show; end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)

    if @author.valid?
      @author.save
      redirect_to @author
    else
      flash[:author] = @author.errors.messages
      redirect_back fallback_location: new_author_path
    end
  end

  def edit; end

  def update
    if @author.update(author_params)
      redirect_to @author
    else
      flash[:author] = @author.errors.messages
      redirect_back fallback_location: edit_author_path(@author)
    end
  end

  def destroy
    if @author.destroy
      redirect_to authors_path
    else
      flash[:error] = 'Could not delete author.'
      redirect_back
    end
  end

  private

  def author_params
    params.require(:author).permit(:name, :email, :email_confirmation)
  end

  def set_author
    @author = Author.find(params[:id])
  end
end
