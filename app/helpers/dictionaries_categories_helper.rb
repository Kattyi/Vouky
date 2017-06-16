module DictionariesCategoriesHelper

  def categories_for_word(word_id)
    @categories_ids = DictionariesCategory.where(dictionary_id: word_id)
  end

end
