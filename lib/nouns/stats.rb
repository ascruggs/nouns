module Nouns
  class Stats

    def self.table
      self.new.table
    end

    def day
      @day ||= {
        created: created(Date.today.beginning_of_day).size,
        completed: completed((Date.today.beginning_of_day)).size,
        modified: modified((Date.today.beginning_of_day)).size,
      }
    end

    def week
      @week ||= {
        created: created(Date.today.beginning_of_week).size,
        completed: completed((Date.today.beginning_of_week)).size,
        modified: modified((Date.today.beginning_of_week)).size,
      }
    end

    def month
      @month ||= {
        created: created(Date.today.beginning_of_month).size,
        completed: completed((Date.today.beginning_of_month)).size,
        modified: modified((Date.today.beginning_of_month)).size,
      }
    end

    def table
      rows = [
        ['completed',day[:completed], week[:completed], month[:completed]],
        ['created',day[:created], week[:created], month[:created]],
        ['modified',day[:modified], week[:modified], month[:modified]]
      ]
      Terminal::Table.new :headings => [nil,'day', 'week', 'month'], :rows => rows
    end

    def created(since_date)
      todos.select{|todo| todo.creation_date && todo.creation_date > since_date }
    end

    def completed(since_date)
      todos.select{|todo| todo.completion_date && todo.completion_date > since_date }
    end

    def modified(since_date)
      todos.select{|todo| todo.modification_date && todo.modification_date > since_date }
    end

    def todos
      @todos ||= Nouns::Things::Todo.all
    end

  end
end