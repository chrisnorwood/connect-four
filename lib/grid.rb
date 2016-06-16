require 'string'

class Grid
  attr_accessor :data, :winner
  
  def initialize
    # each item in @data represents column 1-7 on grid display
    #   each column may have up to 6 members
    #   new members added to top of stack
    @data = [[], [], [], [], [], [], []]
    @winner = nil
  end

  def display
    print "\n- 1 - 2 - 3 - 4 - 5 - 6 - 7 -\n"
    6.times do |row|
      
      7.times do |column|
        print_order = @data[column].reverse
        item = print_order[5-row]
        if item.nil?
          str = "|   "
        else
          str = "|"+"   ".color(item)
        end
        print str
      end

      print "|\n"
      print "|---------------------------|\n"
    end
  end

  def move column, color_sym
    column_index = column - 1
    if !column_full?(column)
      @data[column_index].unshift(color_sym)
      true
    else
      false
    end
  end

  def column_full? column
    column_index = column - 1
    if @data[column_index].size < 6
      false
    else
      true
    end
  end

  def winner?
    if vertical_win? || horizontal_win? || diagonal_win?
      return @winner
    else
      false
    end
  end

  def vertical_win?
    @data.each do |column|
      if column.size >= 4 && column[0..3].all?{ |x| x == column[0] }
        @winner = column[0]
        return true
      end
    end
    false
  end

  def horizontal_win?
    bottom_up = @data.map { |col| col.reverse }

    6.times do |row|
      4.times do |low|
        if bottom_up[low..low+3].all? { |col| col[row] == bottom_up[low][row] }
          if !bottom_up[low][row].nil?
            @winner = bottom_up[low][row]
            return true
          end
        end
      end
    end
    false
  end

  def diagonal_win?
    bottom_up = @data.map { |col| col.reverse }

    7.times do |x|
      6.times do |y|
        tmp = []
        # check right
        if x <= 3
          # up
          if y <= 2
            4.times do |i|
              tmp << bottom_up[x+i][y+i]
            end
            if tmp.all? { |item| item == tmp[0]} && !tmp[0].nil?
              @winner = tmp[0]
              return true 
            end
          end
          # down
          if y >= 3
            4.times do |i|
              tmp << bottom_up[x+i][y-i]
            end
            if tmp.all? { |item| item == tmp[0]} && !tmp[0].nil?
              @winner = tmp[0]
              return true 
            end
          end
        end
        # check left
        if x >= 3
          # up
          if y <= 2
            4.times do |i|
              tmp << bottom_up[x-i][y+i]
            end
            if tmp.all? { |item| item == tmp[0]} && !tmp[0].nil?
              @winner = tmp[0]
              return true 
            end
          end
          # down
          if y >= 3
            4.times do |i|
              tmp << bottom_up[x-i][y-i]
            end
            if tmp.all? { |item| item == tmp[0]} && !tmp[0].nil?
              @winner = tmp[0]
              return true 
            end
          end
        end
      end
    end
    false
  end
end