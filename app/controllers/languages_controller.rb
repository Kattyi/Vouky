class LanguagesController < ApplicationController

  def index
    id = current_user
    if params[:term]
      @languages = Language.joins(:dictionaries)
                       .where(dictionaries: {user_id: id})
                       .where('lower(name) LIKE ?', "%#{params[:term]}%".downcase)
                       .group(:name)
                       .order("count(languages.name) DESC").count
    else
      @languages = Language.joins(:dictionaries)
                       .where(dictionaries: {user_id: id})
                       .group(:name)
                       .order("count(languages.name) DESC")
                       .count
    end
    @languages_ids = Language.joins(:dictionaries).select(:id)

=begin
    SELECT COUNT(*) AS count_all, "languages"."name" AS languages_name
    FROM "languages"
    INNER JOIN "dictionaries" ON "dictionaries"."language_id" = "languages"."id"
    WHERE "dictionaries"."user_id" = 158285
    GROUP BY "languages"."name"
    ORDER BY count(languages.name) DESC
=end


  end

  private

  # whitelist the parameters to prevent wrongful mass assignment
  def dictionary_params
    params.require(:language).permit(:term)
  end

end
