require_relative "../models/address_book.rb" #because this is here and addressbook pulls in entry can essentially
                                             #view all our classes here

class MenuController
    attr_reader :address_book

    def initialize
        @address_book = AddressBook.new #when you create a MenuController object, it automatically creates for you a new AB object
    end

    def main_menu
        puts "\nMain Menu - #{address_book.entries.count} entries"
        puts "1 - View all entries"
        puts "2 - View Entry Number n"
        puts "3 - Create an entry"
        puts "4 - Search for an entry"
        puts "5 - Import entries from a CSV"
        puts "6 - Exit"
        print "\nEnter your selection: "

        #retrieve the selection
        selection = gets.to_i #gets the next thing the user types and converts it to integer and then stores in selection variable

        #time to handle the user input
        case selection
            when 1 #view all entries
                system "clear"
                view_all_entries
                main_menu
            when 2
                system "clear"
                view_entry_by_number
                main_menu
            when 3 #create an entry
                system "clear"
                create_entry
                main_menu
            when 4 #search for an entry
                system "clear"
                search_entries
                main_menu
            when 5 #Import entries from a CSV
                system "clear"
                read_CSV
                main_menu
            when 6 #exit
                puts "Good Bye!"
                exit(0) #exits the ruby script but raises a SystemExit error 0 indicates there is no error here
            else
                system "clear"
                puts "Sorry that is not a valid input"
                main_menu
        end
    end

    def view_all_entries
        address_book.entries.each do |entry|
            system "clear"
            puts entry.to_s #intention is to see 1 entry at a time

            entry_submenu(entry)
        end
    end

    def view_entry_by_number
        print "Please enter the #entry you wish to view: "
        number = gets.to_i
        if(number > address_book.entries.size)
            puts "Sorry their are only ##{address_book.entries.size} entries currently"
            view_by_number_sub_menu
        else
            puts address_book.entries[number-1]
            view_by_number_sub_menu
        end
    end

    def create_entry
        system "clear"
        puts "New Address Bloc Entry"
        
        #give them the ability to add name number and email
        print "Name: " #gives user ability to write on same line
        name = gets.chomp #gets the next thing they type and stores it in variable
        print "Phone Number: "
        phone = gets.chomp
        print "Email: "
        email = gets.chomp

        #this method should call on method in address_book to add an entry
        address_book.add_entry(name, phone,email)

        system "clear"
        puts "New Entry Created"
    end

    def search_entries
    end

    def read_CSV
    end

    def entry_submenu(entry)
        puts "\nn - next entry"
        puts "d - delete entry"
        puts "e - edit this entry"
        puts "m - return to main menu"
        print "\nEnter your selection: "

        selection = gets.chomp #wait for user input - then store in selction

        case selection
            when "n"
                #do nothing here and we will exit the function and just continue with our loop (that will automatically show the next entry)
            when "d"
            when "e"
            when "m"
                system "clear"
                main_menu
            else
                system "clear"
                puts "#{selection} is not a valid input"
                entry_submenu(entry)
        end
    end

    def view_by_number_sub_menu
        puts "\n1 - Make another selection"
        puts "2 - Return to main menu"
        print "\nEnter your selection: "
        selection = gets.to_i
        case selection
            when 1
                system "clear"
                view_entry_by_number
            when 2   
        end
    end

end
