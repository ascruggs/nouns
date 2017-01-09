module Nouns
  module Things
    class Contact

      attr_accessor :app_contact

      def self.all
        Nouns::Things::APP.contacts.get.map do |app_contact|
          Nouns::Things::Contact.new(app_contact)
        end
      end

      def initialize(app_contact)
        self.app_contact = app_contact
      end

      def name
        app_contact.name.get
      end

      def id
        app_contact.id_.get
      end

      def todos
        app_contact.to_dos.get.map do |app_todo|
          Nouns::Things::Todo.new(app_todo)
        end
      end

    end
  end
end
