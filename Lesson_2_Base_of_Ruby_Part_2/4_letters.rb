=begin

Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1)

=end

vowels_hash = Hash.new
vowels_arr = ['а', 'е', 'и', 'о', 'у', 'э', 'ю', 'я', 'ы'] 
vowels_arr.each do |letter|
    vowels_hash[letter] = ('а'..'я').to_a.index(letter) + 1 #в диапазоне ('а'..'я') нет буквы ё
end
