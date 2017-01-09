module Nouns
  module Things
    class Project

      attr_accessor :app_project

      def self.all
        Nouns::Things::APP.projects.get.map do |app_project|
          Nouns::Things::Project.new(app_project)
        end
      end

      def self.find(id)
        app_project = Nouns::Things::APP.projects.get.detect{|app_project|app_project.id_.get == id}
        Nouns::Things::Project.new(app_project)
      end

      def initialize(app_project)
        self.app_project = app_project
      end

      def name
        app_project.name.get
      end

      def id
        app_project.id_.get
      end

      def todos
        app_project.to_dos.get.map do |app_todo|
          Nouns::Things::Todo.new(app_todo)
        end
      end

    end
  end
end
