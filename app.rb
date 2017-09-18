require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/task')
require('./lib/list')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'to_do'})

get('/') do
  @lists = List.all
  erb(:home)
end

post('/') do
  name = params['name']
  new_list = List.new({:name => name, :id => nil})
  new_list.save
  @lists = List.all
  erb(:home)
end

get('/lists/:id') do
  @list_id = params[:id]
  @list = List.find(params.fetch("id").to_i())
  erb(:list)
end

post('/lists/:id') do
  @list = List.find(params.fetch("id").to_i())
  @list_id = params[:id]
  task = params['task']
  due_date = params['due_date']
  new_task = Task.new({:description => task, :due_date => due_date, :list_id => @list_id})
  new_task.save
  @tasks = Task.all
  erb(:list)
end
