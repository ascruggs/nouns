module Nouns
  module Things
    class Area

      attr_accessor :app_area

      def self.all
        Nouns::Things::APP.areas.get.map do |app_area|
          Nouns::Things::Area.new(app_area)
        end
      end

      def initialize(app_area)
        self.app_area = app_area
      end

      def name
        app_area.name.get
      end

      def id
        app_area.id_.get
      end

      def todos
        app_area.to_dos.get.map do |app_todo|
          if app_todo.class_.get != :project
            Nouns::Things::Todo.new(app_todo)
          end
        end.compact
      end

      def projects
        app_area.to_dos.get.map do |app_todo|
          if app_todo.class_.get == :project
            Nouns::Things::Project.find(app_todo.id_.get)
          end
        end.compact
      end

    end
  end
end