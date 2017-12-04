require_relative "entry" #pulls in the entry.rb file relative to my project
require "csv" #pulls in csv class which is installed in the system

class AddressBook
    attr_reader :entries

    def initialize
        @entries = []
    end

    def add_entry(name, phone_number, email)
        index = 0 #initial insert will be at index 0
        
        entries.each do |entry| #before insert go through entries array and find the right index to insert in
            if(name < entry.name) #compare name entered to all names in there and organise lexiographically
                break
            else
                index+=1
            end
        end

        entries.insert(index, Entry.new(name, phone_number, email)) #inserts entry object in entries array at index
    end

    def import_from_csv(file_name)
        csv_text = File.read(file_name) #returns file as a "string" 
        csv = CSV.parse(csv_text, headers: true, skip_blanks: true) #parses csv out of string, returns array of arrays

        csv.each do |row| #iterates over every row (array)
            row_hash = row.to_hash #uses headers as key for each column 
            add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"]) #access that rows hash through key which is our headers in our csv file       
        end
    end

    def binary_search(name) #returns an object in entry based off name
        #search boundaries
        lower = 0 #start of array - after search lower + end will be defined off the middle index
        upper = entries.length-1 #end of array

        while lower<=upper #make sure search is only conducted whilst there is at least something in the array
            mid = (lower + upper) / 2 #find middle index - always recalcualted at beginning of each loop - Ruby automaticall rounds down
            mid_name = entries[mid].name #get the name at that middle index

            if name == mid_name #we have found our name
                return entries[mid] #return that entry object
            elsif name < mid_name #compare alpahbetically that name comes before the middle name in the array
                upper = mid-1 #make the top of my array search only upto less than the middle index
            elsif name > mid_name #name ahead alphabetically
                lower = mid+1
            end
        end
        return nil #after the while loop if never find name or initially we never entered the while loop becuase entries had no entry in there
    end

    def iterative_search(name)
        entries.each {|entry| return entry if name == entry.name}
        nil
    end
end