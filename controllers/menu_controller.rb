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
        puts "2 - Create an entry"
        puts "3 - Search for an entry"
        puts "4 - Import entries from a CSV"
        puts "5 - Nuke Your Address Book"
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
            when 2 #create an entry
                system "clear"
                create_entry
                main_menu
            when 3 #search for an entry
                system "clear"
                search_entries
                main_menu
            when 4 #Import entries from a CSV
                system "clear"
                read_CSV
                main_menu
            when 5 #nuke the address book
                system "clear"
                delete_all_entries
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
        print "Search by name: " 
        name = gets.chomp #get hold of the name we will use to conduct the binary search

        match = address_book.binary_search(name) #this could return either entry object or nil
        system "clear"

        if match #is true so is not nil
            puts match.to_s #displays as string
            search_submenu(match) #pulls up a submenu with a parameter of entry object
        else #search returned nil
            puts "No match found for #{name}" #program exits search_entries function and recalls main_menu function
        end
    end

    def read_CSV
        print "Enter CSV file to import: "
        file_name = gets.chomp

        if file_name.empty? #check file has some substance
            system "clear"
            puts "No CSV file read"
            main_menu
        end

        begin
            entries_count = address_book.import_from_csv(file_name).count #import the file and get the count
            system "clear"
            puts "#{entries_count} new entries added from #{file_name}"
        rescue #if any exception is thrown
            puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
            read_CSV
        end
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
                delete_entry(entry)
            when "e"
                edit_entry(entry)
                entry_submenu(entry)
            when "m"
                system "clear"
                main_menu
            else
                system "clear"
                puts "#{selection} is not a valid input"
                entry_submenu(entry)
        end
    end

    def search_submenu(entry)
        puts "\nd - delete entry"
        puts "e - edit this entry"
        puts "m - return to main menu"
        print "\nEnter your selection: "

        selection = gets.chomp

        case selection
            when "d"
                system "clear"
                delete_entry(entry)
                main_menu
            when "e"
                edit_entry(entry)
                system "clear"
                main_menu
            when "m"
                system "clear"
                main_menu
            else
                system "clear"
                puts "#{selection} is not a valid input"
                puts entry.to_s #re displays the entry searched for as it was
                search_submenu(entry) #and brings back the submenu
        end


    end

    def delete_entry(entry)
        address_book.entries.delete(entry)
        puts "#{entry.name} has been deleted"
    end

    def edit_entry(entry)
        print "Updated Name: "
        name = gets.chomp
        print "Updated Phone Number: "
        phone_number = gets.chomp
        print "Updated Email: "
        email = gets.chomp           #save all user entries to these variables

        entry.name = name if !name.empty? #if name was entered use it to override the name attribute on the entry object
        entry.phone_number = phone_number if !phone_number.empty?
        entry.email = email if !email.empty?
        system "clear"

        puts "Updated Entry:"
        puts entry
    end

    def delete_all_entries
        puts "you currently have ##{address_book.entries.size} entries in your address book"
        puts "LAUNCHING NUKE..."
        address_book.entries.clear
        puts "Nuke Successful :)"
        puts "Their are now ##{address_book.entries.size} entries in your address book"
    end
end
