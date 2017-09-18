class Task
  attr_reader(:description, :list_id)

  def initialize(attributes)
    @description = attributes[:description]
    @list_id = attributes.fetch(:list_id)
  end

  def self.all
    returned_task = DB.exec('SELECT * FROM tasks;')
    tasks = []
    returned_task.each do |task|
      description = task['description']
      list_id = task["list_id"].to_i
      tasks.push(Task.new({:description => description, :list_id => list_id}))
    end
    tasks
  end

  def save
     DB.exec("INSERT INTO tasks (description, list_id) VALUES ('#{@description}', #{@list_id});")
  end

  def ==(another_task)
    self.description().==(another_task.description()).&(self.list_id().==(another_task.list_id()))
  end
end
