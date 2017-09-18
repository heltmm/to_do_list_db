require('rspec')
require('pg')
require('task')
require("spec_helper")

DB = PG.connect({:dbname => 'to_do_test'})

describe(Task) do
  describe(".all") do
    it("is empty at first") do
      expect(Task.all()).to(eq([]))
    end
  end

  describe(".all") do
    it("sorts multiple tasks by due date") do
      test_task1 = Task.new({:description => "learn SQL", :list_id => 1, :due_date => '2017-09-22 08:00:00'})
      test_task1.save()
      test_task2 = Task.new({:description => "learn SQL", :list_id => 1, :due_date => '2017-08-19 08:00:00'})
      test_task2.save()
      test_task3 = Task.new({:description => "learn SQL", :list_id => 1, :due_date => '2017-08-10 08:00:00'})
      test_task3.save()
      expect(Task.all()).to(eq([test_task3, test_task2, test_task1]))
    end
  end

  describe("#save") do
    it("adds a task to the array of saved tasks") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1, :due_date => '2017-09-19 08:00:00'})
      test_task.save()
      expect(Task.all()).to(eq([test_task]))
    end
  end

  describe("#description") do
    it("lets you read the description out") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1, :due_date => '2017-09-19 08:00:00'})
      expect(test_task.description()).to(eq("learn SQL"))
    end
  end

  describe("#due_date") do
    it("lets you read the due date out") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1, :due_date => '2017-09-19 08:00:00'})
      expect(test_task.due_date()).to(eq('2017-09-19 08:00:00'))
    end
  end

  describe("#list_id") do
    it("lets you read the list ID out") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1, :due_date => '2017-09-19 08:00:00'})
      expect(test_task.list_id()).to(eq(1))
    end
  end

  describe("#==") do
    it("is the same task if it has the same description and list ID") do
      task1 = Task.new({:description => "learn SQL", :list_id => 1, :due_date => '2017-09-19 08:00:00'})
      task2 = Task.new({:description => "learn SQL", :list_id => 1, :due_date => '2017-09-19 08:00:00'})
      expect(task1).to(eq(task2))
    end
  end
end
