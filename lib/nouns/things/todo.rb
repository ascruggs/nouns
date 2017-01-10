module Nouns
  module Things
    class Todo

      COLUMNS = ['name', 'notes', 'creation_date', 'completion_date','status', 'id']

      include Nouns::Things::Datable
      include Memoizable

      attr_accessor :app_todo

      def self.all
        Nouns::Things::APP.to_dos.get.map do |app_todo|
          Nouns::Things::Todo.new(app_todo)
        end
      end

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
          'creation_date' => creation_date,
          'due_date' => due_date,
          'activation_date' => activation_date,
          'cancellation_date' => cancellation_date,
          'modification_date' => modification_date,
          'app_class' => app_class,
        }
      end

      def id
        memoize { app_todo.id_.get }
      end

      def name
        memoize { app_todo.name.get }
      end

      def notes
        memoize { app_todo.notes.get }
      end

      def status
        memoize { app_todo.status.get }
      end

      def app_class
        memoize { app_todo.class_.get }
      end

      def completion_date
        memoize { to_date(app_todo.completion_date.get) }
      end

      def creation_date
        memoize { to_date(app_todo.creation_date.get) }
      end

      def due_date
        memoize { to_date(app_todo.due_date.get) }
      end

      def activation_date
        memoize { to_date(app_todo.activation_date.get) }
      end

      def cancellation_date
        memoize { to_date(app_todo.cancellation_date.get) }
      end

      def modification_date
        memoize { to_date(app_todo.modification_date.get) }
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