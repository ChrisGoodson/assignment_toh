class TowersOfHanoi

  attr_accessor :total_moves

  @winner = false

  def initialize(num)
    @tower_height = num
    @total_moves = 0
  end

  def board
    j = @tower_height
    @board = [[],[],[]]
    @tower_height.times do
      @board[0] << "(" + "-" * j + ")"
      j -= 1
    end
  end

  def rules
    puts "\n\n\n\t\t\t\t\tTowers of Hanoi\n\n\t\t\t\tYou must move all the disks from\n\t\t\t\tthe first tower to the last tower\n\t\t\t\twithout placing a larger disk on a smaller disk.\n\t\t\t\tYour first tower will be #{@tower_height} disks.\n\t\t\t\tYour moves must be in the format of an array\n\t\t\t\twhere the first number is from\n\t\t\t\tand the second number is the to.\n\t\t\t\tType q, quit, or exit to leave the game."
  end

  def input?(move)
     if move.match(/^\[\d\,\d\]$/) != nil 
      return true
     else
      return false
     end
  end

  def converter(move)
    move = move.gsub(/\W/, '').split('').map! {|k| k.to_i}
    move = move.map do |i|
      if i > 1
        i - 1
      elsif i == 1
        i = 0   
      end
    end
  end

  def is_move?(arr)

    case
    when @board[arr[0]] == @board[arr[1]] then false
    when arr[0] > (@tower_height - 1) || arr[1] > (@tower_height - 1) then false
    when @board[arr[0]].empty? then false
    when @board[arr[1]].empty? then true
    when @board[arr[1]].empty? == false then @board[arr[0]].last.length < @board[arr[1]].last.length
    else false
    end
  end

  def winner?
    @board.each_with_index do |i, j|
      if i.length == @tower_height && j != 0
        puts "Winner in #{total_moves()} moves."
        return @winner = true
      end
    end
  end

  def moves
    puts "\t\tTo move a disk, type an array."
    loop do
      print "\t\t\t\t "
      @move = gets.chomp
      if @move.downcase == "q" || @move.downcase == "quit" || @move.downcase == "exit"
        exit
      elsif input?(@move)
        @move = converter(@move)
        if is_move?(@move)
          @total_moves +=1

          break
        else
          puts "You must place a smaller disk on top of a larger disk."
        end
      else
      puts "Your move must be in the form of an array"
      end 
    end
    puts "Move number #{total_moves()}"
  end

  def change_board
    ring = @board[@move[0]].pop
    @board[@move[1]].push(ring)
  end

  def builder
    new_board = @board.each_with_index do |i,j|
      puts ""
      i.reverse.each do |disks|
        puts disks.ljust(@tower_height)
      end
      puts (j+ 1).to_s.center(@tower_height)
      puts ""
    end
  end

  def play
    rules
    board
    builder
    while !(@winner)
      total_moves
      moves
      change_board
      builder
      winner?
    end
  end
end