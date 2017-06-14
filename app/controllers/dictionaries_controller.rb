class DictionariesController < ApplicationController

  include DictionariesCategoriesHelper

  def index
    search_pattern = 'lower(word) LIKE ? OR lower(translation) LIKE ?'
    if params[:term]
      @dictionaries = Dictionary.where(user_id: current_user.id)
                                .where(search_pattern, "%#{params[:term]}%".downcase, "%#{params[:term]}%".downcase)
                                .where(language_id: params[:language])
                                .order(created_at: :desc)
                                .page params[:page]
    else
      @dictionaries = Dictionary.where(user_id: current_user.id)
                                .where(language_id: params[:language])
                                .order(created_at: :desc)
                                .page params[:page]
    end
    @dictionaries.without_count

    @language_list = Language.all
    @categories_list = Category.all

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

    EasyTranslate.api_key = 'AIzaSyDPn-JkZmeKQOWMgjpBBgIRkta3LRQyX-Q'

    if dictionary_params[:word].blank? and dictionary_params[:translation].blank?
      flash[:danger] = "Please fill in word or translation"
      redirect_back fallback_location: dictionaries_path
    else
      @dictionary = Dictionary.create(dictionary_params)
      mother_lang = Language.find(current_user.language_id).name.downcase

      if @dictionary.translation.empty?
        source_lang = Language.find(@dictionary.language_id).name.downcase
        @dictionary.translation = EasyTranslate.translate(@dictionary.word, from: source_lang, to: mother_lang)
      elsif @dictionary.word.empty?
        dest_lang = Language.find(@dictionary.language_id).name.downcase
        @dictionary.word = EasyTranslate.translate(@dictionary.translation, from: mother_lang, to: dest_lang)
      end
      @dictionary.save
      flash[:success] = @dictionary.word + " created"
      redirect_to dictionaries_path(language: @dictionary.language_id)
    end

  end


  def update
    @dictionary = Dictionary.find(params[:id])
    flash[:success] = @dictionary.word + " edited"
    @dictionary.update(dictionary_params)
    redirect_to dictionaries_path(language: @dictionary.language_id)
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
