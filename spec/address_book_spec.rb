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

    describe "#import_from_csv" do
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

    describe "#binary_search" do
        it "searches our addressbook (entries array) for a non-existent entry object" do
            book.import_from_csv("entries.csv") #adds 5 entry objects to entries array
            entry = book.binary_search("Dan") #if i was to search for Dan
            expect(entry).to be_nil
        end
        
        it "searches address book for Bill" do
            book.import_from_csv("entries.csv") #adds 5 entry objects to entries array
            entry = book.binary_search("Bill") #makes that search for the object Bill in our entry array
            expect(entry).to be_a(Entry) #first thing we expect is that the entry returned will be an object of the class type Entry
            check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")# 3 EXPECTS IN HERE - check the object that we got held in entry, really equates to the Bill object
        end

        it "searches AddressBook for Bob" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Bob")
            expect(entry).to be_a Entry
            check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
        end
      
        it "searches AddressBook for Joe" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Joe")
            expect(entry).to be_a Entry
            check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
        end
      
        it "searches AddressBook for Sally" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Sally")
            expect(entry).to be_a Entry
            check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
        end
      
        it "searches AddressBook for Sussie" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Sussie")
            expect(entry).to be_a Entry
            check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
        end

        it "searches AddressBook for Billy" do
            book.import_from_csv("entries.csv")
            entry = book.binary_search("Billy")
            expect(entry).to be_nil
        end
    end
end