class Task
  attr_reader(:description, :list_id, :due_date)

  def initialize(attributes)
    @description = attributes[:description]
    @list_id = attributes.fetch(:list_id)
    @due_date = attributes.fetch(:due_date)
  end

  def self.all
    returned_task = DB.exec('SELECT * FROM tasks ORDER BY due_date;')
    tasks = []
    returned_task.each do |task|
      description = task['description']
      due_date = task['due_date']
      list_id = task["list_id"].to_i
      tasks.push(Task.new({:description => description, :list_id => list_id, :due_date => due_date}))
    end
    tasks
  end

  def save
     DB.exec("INSERT INTO tasks (description, list_id, due_date) VALUES ('#{@description}', #{@list_id}, '#{@due_date}');")
  end

  def ==(another_task)
    self.description.==(another_task.description).&(self.list_id.==(another_task.list_id)).&(self.due_date.==(another_task.due_date))
  end
end
