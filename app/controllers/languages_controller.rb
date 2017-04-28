class LanguagesController < ApplicationController

  def index
    id = current_user
    @languages = Language.joins(:dictionaries).where(dictionaries: {user_id: id}).group(:name).order("count(languages.name) DESC").count
    @languages_ids = Language.joins(:dictionaries).select(:id)
  end

  # TODO dorobit search

end
