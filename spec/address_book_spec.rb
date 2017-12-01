require_relative "../models/address_book.rb"

RSpec.describe "AddressBook" do
    let(:book) {AddressBook.new}

    def check_entry(entry, expected_name, expected_number, expected_email)
        expect(entry.name).to eq(expected_name) #remember each array cell is holding an entry object with the following attributes
        expect(entry.phone_number).to eq(expected_number)
        expect(entry.email).to eq(expected_email)
    end

    describe "attributes" do 
        it "responds to entries" do
            expect(book).to respond_to(:entries)        
        end
        it "initializes entries as an array" do
            expect(book.entries).to be_an(Array)
        end
        it "initializes entries as empty" do
            expect(book.entries.size).to eq(0)
        end
    end

    describe "#add_entry" do
        it "adds only one item to the address book" do
            book.add_entry("Sami", "0204648518", "sami@email.com")
            expect(book.entries.size).to eq(1)
        end
        it "adds the correct information to entries" do
            book.add_entry("Sami", "0204648518", "sami@email.com")
            check_entry(book.entries[0], "Sami", "0204648518", "sami@email.com" )
        end
    end

    describe "#import_from_csv (using entries.csv)" do
        it "imports the correct number of entries" do
            book.import_from_csv("entries.csv") #call the actual method
            book_size = book.entries.size #following import method check size of entries array
            expect(book_size).to eq(5) #the assumption is we imported 5 entries through our csv file
        end
        it "imports the first entry" do
            book.import_from_csv("entries.csv")
            entry_one = book.entries[0]

            check_entry(entry_one, "Bill", "555-555-4854", "bill@blocmail.com")
        end
        it "imports the 2nd entry" do
            book.import_from_csv("entries.csv")
            entry_two = book.entries[1]
            
            check_entry(entry_two, "Bob", "555-555-5415", "bob@blocmail.com")
        end
      
        it "imports the 3rd entry" do
            book.import_from_csv("entries.csv")
            entry_three = book.entries[2]
            
            check_entry(entry_three, "Joe", "555-555-3660", "joe@blocmail.com")
        end
      
        it "imports the 4th entry" do
            book.import_from_csv("entries.csv")
            entry_four = book.entries[3]
            
            check_entry(entry_four, "Sally", "555-555-4646", "sally@blocmail.com")
        end
      
        it "imports the 5th entry" do
            book.import_from_csv("entries.csv")
            entry_five = book.entries[4]
            
            check_entry(entry_five, "Sussie", "555-555-2036", "sussie@blocmail.com")
        end
    end

        
    describe "#import_from_csv (using entries_2.csv)" do
        it "imports the correct number of entries" do
            book.import_from_csv("entries_2.csv")
            book_size = book.entries.size 
            expect(book_size).to eq(3) 
        end
        it "imports the first entry" do
            book.import_from_csv("entries_2.csv")
            entry_one = book.entries[0]

            check_entry(entry_one, "Adam", "555-555-4854", "Sami@blocmail.com")
        end
        it "imports the 2nd entry" do
            book.import_from_csv("entries_2.csv")
            entry_two = book.entries[1]
            
            check_entry(entry_two, "Mike", "555-555-5415", "mike@blocmail.com")
        end
      
        it "imports the 3rd entry" do
            book.import_from_csv("entries_2.csv")
            entry_three = book.entries[2]
            
            check_entry(entry_three, "Papa", "555-555-3660", "joe@blocmail.com")
        end
    end
end