=begin

Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара (может быть нецелым числом).
Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве названия товара.
На основе введенных данных требуетеся:
Заполнить и вывести на экран хеш, ключами которого являются названия товаров,
а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара.
Также вывести итоговую сумму за каждый товар.
Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

=end

buy_list_hash = Hash.new
print "Введите название товара, цену за еденицу и количество через пробел: "
user_input = gets.chomp
while user_input != 'стоп'
    name, price, count = user_input.split
    buy_list_hash[name] = {price.to_f.round(2) => count.to_f}
    print "Ещё: "
    user_input = gets.chomp
end

summa = 0
buy_list_hash.each do |name, money|
    money.each do |price, count|
        puts "#{name}: \t#{price} р./ед., кол-во: #{count} \tВсего: #{(price * count).round(2)}"
        summa += (price * count).round(2)
    end
end
puts "Итого: #{summa} р."
gets
