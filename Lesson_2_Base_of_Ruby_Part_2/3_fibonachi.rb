=begin

Заполнить массив числами фибоначчи до 100

=end


fibonachi_arr = [0, 1]
loop do
    n = fibonachi_arr[-1] + fibonachi_arr[-2]
    break if n > 100
    fibonachi_arr.push(n)
end 
