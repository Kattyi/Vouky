class DictionariesController < ApplicationController

  # OPTIMIZE move to model dictionary.rb
  def index
    user = current_user
    search_pattern = 'lower(word) LIKE ? OR lower(translation) LIKE ?'
    if params[:term]
      @dictionaries = user.dictionaries
                          .where(search_pattern, "%#{params[:term]}%".downcase, "%#{params[:term]}%".downcase)
                          .order(created_at: :desc)
                          .page params[:page]
    else
      @dictionaries = user.dictionaries
                          .where(language_id: params[:language])
                          .order(created_at: :desc)
                          .page params[:page]
    end
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
    redirect_back(fallback_location: dictionaries_path)
  end


  def update
    @dictionary = Dictionary.find(params[:id])
    flash[:success] = @dictionary.word + " edited"
    @dictionary.update(dictionary_params)
    redirect_to dictionaries_path(:language_id => params[:language])
  end

  def destroy
    @dictionary = Dictionary.find(params[:id])
    flash[:success] = @dictionary.word + " deleted"
    @dictionary.destroy
    redirect_back(fallback_location: dictionaries_path)
  end

  private

  # whitelist the parameters to prevent wrongful mass assignment
  def dictionary_params
    params.require(:dictionary).permit(:word, :translation, :user_id, :term, :language_id)
  end

end
