class DictionariesController < ApplicationController

  include DictionariesCategoriesHelper

  def index
    search_pattern = 'lower(word) LIKE ? OR lower(translation) LIKE ?'
    if params[:term]
      if params[:category_id]
        @dictionaries = Dictionary
                            .joins(:dictionaries_categories)
                            .where(dictionaries_categories: {category_id: params[:category_id]})
                            .where(user_id: current_user.id)
                            .where(language_id: params[:language])
                            .where(search_pattern, "%#{params[:term]}%".downcase, "%#{params[:term]}%".downcase)
                            .order(created_at: :desc)
                            .paginate(page: params[:page]).per_page(30)
      else
        @dictionaries = Dictionary
                            .where(user_id: current_user.id)
                            .where(language_id: params[:language])
                            .where(search_pattern, "%#{params[:term]}%".downcase, "%#{params[:term]}%".downcase)
                            .order(created_at: :desc)
                            .paginate(page: params[:page]).per_page(30)
      end
    else
      if params[:category_id]
        @dictionaries = Dictionary
                            .joins(:dictionaries_categories)
                            .where(dictionaries_categories: {category_id: params[:category_id]})
                            .where(user_id: current_user.id)
                            .where(language_id: params[:language])
                            .order(created_at: :desc)
                            .paginate(page: params[:page]).per_page(30)

      else
        @dictionaries = Dictionary
                            .where(user_id: current_user.id)
                            .where(language_id: params[:language])
                            .order(created_at: :desc)
                            .paginate(page: params[:page]).per_page(30)
      end
    end

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
    @categories_list = Category.all
  end

  def create

    EasyTranslate.api_key = 'AIzaSyDPn-JkZmeKQOWMgjpBBgIRkta3LRQyX-Q'

    if dictionary_params[:word].blank? and dictionary_params[:translation].blank?
      flash[:danger] = "Please fill in word or translation"
      redirect_back fallback_location: dictionaries_path
    else
      @dictionary = Dictionary.create(dictionary_params)
      mother_lang = Language.find(current_user.language_id).name.downcase
      source_dest_lang = Language.find(@dictionary.language_id).name.downcase

      if @dictionary.translation.empty?
        @dictionary.translation = EasyTranslate.translate(@dictionary.word, from: source_dest_lang, to: mother_lang)
      elsif @dictionary.word.empty?
        @dictionary.word = EasyTranslate.translate(@dictionary.translation, from: mother_lang, to: source_dest_lang)
      end

      @dictionary.save

      @dictionaries_category = DictionariesCategory.where(dictionary_id: @dictionary.id, category_id: params[:dictionary][:dictionaries_category][:category_id])
                                   .first_or_create(dictionary_id: @dictionary.id, category_id: params[:dictionary][:dictionaries_category][:category_id])

      flash[:success] = @dictionary.word + " - CREATED"
      redirect_to dictionaries_path(language: @dictionary.language_id)
    end

  end


  def update
    @dictionary = Dictionary.find(params[:id])
    flash[:success] = @dictionary.word + " - EDITED"
    @dictionary.update(dictionary_params)

    @dictionaries_category = DictionariesCategory.where(dictionary_id: @dictionary.id, category_id: params[:dictionary][:dictionaries_category][:category_id])
                                 .first_or_create(dictionary_id: @dictionary.id, category_id: params[:dictionary][:dictionaries_category][:category_id])

    redirect_to edit_dictionary_path(@dictionary)
  end

  def destroy
    @dictionary = Dictionary.find(params[:id])
    flash[:success] = @dictionary.word + " - DELETED"
    @dictionary.destroy
    redirect_back(fallback_location: dictionaries_path)
  end

  private

  # whitelist the parameters to prevent wrongful mass assignment
  def dictionary_params
    params.require(:dictionary).permit(:word, :translation, :user_id, :term, :language_id, :dictionaries_category)
  end

  def dictionaries_categories_params
    params.permit(:category_id, :dictionary_id)
  end

end
