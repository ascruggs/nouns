require 'csv'

module Nouns
  module Syncer
    class Meeting

      DIR = "/Users/aascruggs/Dropbox/Documents/Meetings"
      COLUMNS = ['name', 'notes', 'creation_date', 'completion_date','status',  'id']

      attr_accessor :project

      def self.sync!
        area = Nouns::Things::Area.all.detect{|area| area.name == "Meetings"}
        area.projects.map do |project|
          Nouns::Syncer::Meeting.new(project).sync!
        end
      end

      def initialize(project)
        self.project = project
      end

      def sync!
        update_csv_records
        save_csv_records
      end

      def update_csv_records
        project.todos.each do |todo|
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
            csv << Nouns::Syncer::Meeting::COLUMNS.map{|attribute| csv_record[attribute]}
          end
        end
      end

      def file
        "#{Nouns::Syncer::Meeting::DIR}/#{project.name}.csv"
      end

      def csv_records
        @csv_records ||= CSV.read(file, headers: true).map(&to_hash) rescue []
      end

    end
  end
end