# frozen_string_literal: true

module Enumerable
  def my_each 
    for i in 0...self.length
      yield(self[i])
    end
  end
  [1, 2, 3, 6, 5].my_each { |i| puts i }

def my_each_with_index 
   for i in 0...self.length
    yield(i,self[i])
      end
    end
    [7, 9, 33, 61, 15].my_each_with_index { |i, element| puts "#{i} " "#{element}" }

    def my_select
        invited_list =[]
          self.my_each do |friend|
            if yield(friend)
              invited_list.push(friend)
            end
          end   
          return invited_list      
    end
    not_invited = "Talha"
puts ["Haroon","Umair","Talha", "Jaqob","Asahad"].my_select { |friend| friend != not_invited}
def my_all?
    check = false
    self.my_each do |i|
        if yield(i) == true
            check = true
        else
            check = false
            return check
         end
    end
    return check
end
puts "\n"
puts ["Haroon","Umair","Talhaaaa", "Jaqob","Asahad"].my_all? { |friend| friend.length < 7}

def my_none?
    check = false
    self.my_each do |i|
        if yield(i) == true
            check = false
            return check
        else
            check = true
        end
    end
    return check
end

puts "\n"
puts ["Haroon","Umair","Talha", "Jaqob","Asahad"].my_none? { |friend| friend.length < 7}

end
