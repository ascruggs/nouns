require 'csv'

module Nouns
  module Syncer
    class People

      DIR = "/Users/aascruggs/Dropbox/Documents/People"

      attr_accessor :contact

      def self.sync!
        Nouns::Things::Contact.all.map do |contact|
          Nouns::Syncer::People.new(contact).sync!
        end
      end

      def initialize(contact)
        self.contact = contact
      end

      def sync!
        update_csv_records
        save_csv_records
      end

      def update_csv_records
        contact.todos.each do |todo|
          find_or_create_csv_record(todo)
        end
      end

      def find_or_create_csv_record(todo)
        if csv_record = csv_records.detect{|csv_record| csv_record['id'] == todo.id}
          csv_record.merge!(todo.attributes)
        else
          csv_records << todo.attributes
        end
      end

      def save_csv_records
        CSV.open(file, "w") do |csv|
          csv << Nouns::Things::Todo::COLUMNS
          csv_records.each do |csv_record|
            csv << Nouns::Things::Todo::COLUMNS.map{|attribute| csv_record[attribute]}
          end
        end
      end

      def file
        "#{Nouns::Syncer::People::DIR}/#{contact.name}.csv"
      end

      def csv_records
        @csv_records ||= CSV.read(file, headers: true).map(&to_hash) rescue []
      end

    end
  end
end