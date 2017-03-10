class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  include TasksHelper
  # GET /tasks
  def index
    if !current_user.nil?
    params.delete_if{|k,v| v=='' || v=='0' }
    @only_actual = params[:state_id].nil?
    @executor = params[:executor_id] || current_user.id

    all_ids = Task.all.ids
    a_ids = p_ids = pst_ids = pd_ids = pt_ids = s_ids = c_ids = u_ids = e_ids = cl_ids = all_ids

    p_ids   = Priority.find(params[:priority_id]).tasks.ids if !params[:priority_id].nil?
    pst_ids = State.find(params[:state_id]).tasks.ids if !params[:state_id].nil?
    pt_ids  = TaskType.find(params[:task_type_id]).tasks.ids if !params[:task_type_id].nil?
    pd_ids  = TaskDept.find(params[:dept_id]).tasks.ids if !params[:dept_id].nil?
    c_ids   = Component.find(params[:component_id]).tasks.ids if !params[:component_id].nil?
    cl_ids   = Client.find(params[:client_id]).tasks.ids if !params[:client_id].nil?
    e_ids   = User.find(@executor).tasks.ids if !@executor.nil? && current_user.admin?

    if !params[:search].nil?
       s_ids = Task.where('LOWER(name) like LOWER(?)', '%'+params[:search]+'%').ids
    end


    if current_user.admin?
      a_ids = Task.where('executor_id = ? and state_id < 5', @executor).ids if @only_actual
    else
      a_ids = Task.where('state_id < 5').ids if @only_actual
      u_ids = current_user.dept.tasks.ids if !current_user.dept.nil?
    end

    ids = all_ids & a_ids & p_ids & pst_ids & pd_ids & pt_ids & s_ids & c_ids & u_ids & e_ids & cl_ids

    @order = params[:state_id].nil? || params[:state_id].to_i < 5 ? :start_date : :updated_at

    @tasks = Task.where(:id => ids).order(:cur_order).order(@order)
    store_tasks_path(params)
    else
     @tasks =[]
    end
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @priority_id = 2
    @state_id    = 1
    @type_id     = 1
    @dept        = current_user.dept_id
    @user_id     = current_user.id
    @executor_id = 3
    @date_place  = Date.today()
  end

  # GET /tasks/1/edit
  def edit
    @priority_id = @task.priority_id
    @state_id    = @task.state_id
    @type_id     = @task.task_type_id
    @dept        = @task.dept_id
    @user_id     = @task.user_id
    @executor_id = @task.executor_id
    @date_place  = @task.place_date
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_url, notice: 'Задача успешно создана.'
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1
  def update

    @priority_id = @task.priority_id
    @state_id    = @task.state_id
    @type_id     = @task.task_type_id
    @dept        = @task.dept_id
    @user_id     = @task.user_id
    @executor_id = @task.executor_id
    @date_place  = @task.place_date

    if @task.update(task_params)
      redirect_to tasks_stored_page, notice: 'Задача успешно обновлена.'
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Задача успешно удалена.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:name, :description, :priority_id, :user_id, :state_id, :task_type_id, :dept_id, :place_date,
        :start_date, :end_date, :order, :executor_id,:cur_order, :component_id, :client_id, :client_name, :duration, :hours_plan,:hours_fact)
    end
end
