class DictionariesCategoriesController < ApplicationController

  def destroy
    @dictionaries_category = DictionariesCategory.find(params[:id])
    @dictionaries_category.destroy
    redirect_back(fallback_location: root_path)
  end

end
