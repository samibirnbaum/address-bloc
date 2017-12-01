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
end
