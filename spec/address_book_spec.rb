require_relative "../models/address_book.rb"

RSpec.describe "AddressBook" do
    describe "attributes" do
        let(:book) {AddressBook.new}
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
        let(:book) {AddressBook.new}
        it "adds only one item to the address book" do
            book.add_entry("Sami", "0204648518", "sami@email.com")
            expect(book.entries.size).to eq(1)
        end
        it "adds the correct information to entries" do
            book.add_entry("Sami", "0204648518", "sami@email.com")
            expect(book.entries[0].name).to eq("Sami")
            expect(book.entries[0].phone_number).to eq("0204648518")
            expect(book.entries[0].email).to eq("sami@email.com")
        end
    end
end