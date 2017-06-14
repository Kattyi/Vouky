# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

=begin
1000.times do
  Dictionary.create([{word: Faker::Lorem.word,
                        translation: Faker::Lorem.word,
                        created_at: Faker::Time.between(20.days.ago, Date.today, :all),
                        updated_at: Faker::Time.between(20.days.ago, Date.today, :all),
                        language_id: 13,
                        category_id: Faker::Number.between(1, 199),
                        user_id: 158285
                       }])
end
=end

=begin
533362.times do
  user = User.find_or_initialize_by(email: nil)
  user.email = Faker::Internet.email
  user.save
end
=end


=begin
langs_list = [
    ["af", "afrikaans"],
    ["sq", "albanian"],
    ["ar", "arabic"],
    ["be", "belarusian"],
    ["bg", "bulgarian"],
    ["ca", "catalan"],
    ["zh-CN", "chinese_simplified"],
    ["zh-TW", "chinese_traditional"],
    ["hr", "croatian"],
    ["cs", "czech"],
    ["da", "danish"],
    ["nl", "dutch"],
    ["en", "english"],
    ["et", "estonian"],
    ["tl", "filipino"],
    ["fi", "finnish"],
    ["fr", "french"],
    ["gl", "galician"],
    ["de", "german"],
    ["el", "greek"],
    ["iw", "hebrew"],
    ["hi", "hindi"],
    ["hu", "hungarian"],
    ["is", "icelandic"],
    ["id", "indonesian"],
    ["ga", "irish"],
    ["it", "italian"],
    ["ja", "japanese"],
    ["ko", "korean"],
    ["la", "latin"],
    ["lv", "latvian"],
    ["lt", "lithuanian"],
    ["mk", "macedonian"],
    ["ms", "malay"],
    ["mt", "maltese"],
    ["no", "norwegian"],
    ["fa", "persian"],
    ["pl", "polish"],
    ["pt", "portuguese"],
    ["ro", "romanian"],
    ["ru", "russian"],
    ["sr", "serbian"],
    ["sk", "slovak"],
    ["sl", "slovenian"],
    ["es", "spanish"],
    ["sw", "swahili"],
    ["sv", "swedish"],
    ["th", "thai"],
    ["tr", "turkish"],
    ["uk", "ukrainian"],
    ["vi", "vietnamese"],
    ["cy", "welsh"],
    ["yi", "yiddish"]
]

langs_list.each do |code, name|
  Language.create(name: name.capitalize)
end
=end
