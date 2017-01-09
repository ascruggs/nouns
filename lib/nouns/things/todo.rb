module Nouns
  module Things
    class Todo

      COLUMNS = ['name', 'notes', 'creation_date', 'completion_date','status',  'id']

      include Nouns::Things::Datable

      attr_accessor :app_todo

      def initialize(app_todo)
        self.app_todo = app_todo
      end

      def attributes
        {
          "id" => id,
          "name" => name,
          "notes" => notes,
          "status" => status,
          'completion_date' => completion_date,
          'creation_date' => creation_date
        }
      end

      def id
        app_todo.id_.get
      end

      def name
        app_todo.name.get
      end

      def notes
        app_todo.notes.get
      end

      def status
        app_todo.status.get
      end

      def completion_date
        to_date(app_todo.completion_date.get)
      end

      def creation_date
        to_date(app_todo.creation_date.get)
      end

      def due_date
        to_date(app_todo.due_date.get)
      end

      def activation_date
        to_date(app_todo.activation_date.get)
      end

      def contact
        app_contact = app_todo.contact.get
        Nouns::Things::Contact.new(app_contact)
      end

      def project
        app_todo.project.get
      end

      def area
        app_todo.area.get
      end

    end
  end
end