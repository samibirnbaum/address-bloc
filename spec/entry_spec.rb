require_relative "../models/entry.rb"   #loads the files we will be testing (in this case a relative path)

RSpec.describe Entry do
    
    describe "attributes" do
        let(:entry) {Entry.new("name", "0207956546", "name@email.com")} #runs code and stores it in accessebile variable entry
        it "responds to name" do
            expect(entry).to respond_to(:name) #RSpec test ends with expectation which test will pass/fail on
        end                                    #here the new object should have an attribute called name
        it "reports its name" do
           expect(entry.name).to eq("name")
        end

        it "responds to phone number" do
            expect(entry).to respond_to(:phone_number)
        end
        it "reports its phone number" do
            expect(entry.phone_number).to eq("0207956546")
         end

        it "responds to email" do
            expect(entry).to respond_to(:email)
        end
        it "reports its email" do
            expect(entry.email).to eq("name@email.com")
         end
    end

    describe "#to_s" do # the#=instance method
        it "prints an entry as a string" do
            entry = Entry.new("name", "0207956546", "name@email.com")
            expected_string = "Name: name\nPhone Number: 0207956546\nEmail: name@email.com"
            expect(entry.to_s).to eq(expected_string)
        end
    end
end
