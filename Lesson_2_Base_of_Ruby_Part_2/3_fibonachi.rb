=begin

Заполнить массив числами фибоначчи до 100

=end


fibonachi_arr = [0, 1]
loop do
    n = fibonachi_arr[-2, 2].sum
    break if n > 100
    fibonachi_arr.push(n)
end 
