module Nouns
  class Stats

    def self.today
      self.new.today
    end

    def today
      {
        created: created(Date.today.beginning_of_day).size,
        completed: completed((Date.today.beginning_of_day)).size
      }
    end

    def created(since_date)
      todos.select{|todo| todo.creation_date && todo.creation_date > since_date }
    end

    def completed(since_date)
      todos.select{|todo| todo.completion_date && todo.completion_date > since_date }
    end

    def todos
      @todos ||= Nouns::Things::Todo.all
    end

  end
end