require_relative "entry" #pulls in the entry.rb file

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
end