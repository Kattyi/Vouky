class DictionariesController < ApplicationController

  def index
    @dictionaries = Dictionary.order(created_at: :desc).page params[:page]
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
    @dictionary = Dictionary.new(dictionary_params)
    @dictionary.save
    redirect_to dictionaries_path
  end


  def update
    @dictionary = Dictionary.find(params[:id])
    @dictionary.update(dictionary_params)
    redirect_to dictionaries_path
  end

  def destroy
    @dictionary = Dictionary.find(params[:id])
    @dictionary.destroy
    redirect_to dictionaries_path
  end

  private

  # whitelist the parameters to prevent wrongful mass assignment
  def dictionary_params
    params.require(:dictionary).permit(:word, :translation)
  end

end
