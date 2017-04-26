class DictionariesController < ApplicationController

  def index
    user = current_user
    @dictionaries = user.dictionaries.order(created_at: :desc).page params[:page]
    @dictionaries.without_count
  end

  def show
    @dictionary = Dictionary.find(params[:id])
  end

  def new
    @dictionary = Dictionary.new
  end

  def edit
    @dictionary = Dictionary.find(params[:id])
  end

  def create
    user = current_user
    @dictionary = user.dictionaries.where(dictionary_params).first_or_create(dictionary_params)
    flash[:success] = @dictionary.word + " created"
    redirect_to dictionaries_path
  end


  def update
    @dictionary = Dictionary.find(params[:id])
    flash[:success] = @dictionary.word + " edited"
    @dictionary.update(dictionary_params)
    redirect_to dictionaries_path
  end

  def destroy
    @dictionary = Dictionary.find(params[:id])
    flash[:success] = @dictionary.word + " deleted"
    @dictionary.destroy
    redirect_to dictionaries_path
  end

  private

  # whitelist the parameters to prevent wrongful mass assignment
  def dictionary_params
    params.require(:dictionary).permit(:word, :translation, :user_id)
  end

end
