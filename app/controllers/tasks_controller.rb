class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]

  # Afficher toutes les tâches
  def index
    @tasks = Task.all
  end

  # Afficher une tâche
  def show
  end

  # Formulaire pour créer une nouvelle tâche
  def new
    @task = Task.new
    respond_to do |format|
      format.html # pour les requêtes normales
      format.turbo_stream # pour les requêtes via Turbo Frame
    end
  end


  # Formulaire pour éditer une tâche existante
  def edit
  end

  # Créer une nouvelle tâche
  def create
    @task = Task.new(task_params)
    if @task.save
      respond_to do |format|
        format.html { redirect_to tasks_path, notice: "Tâche créée avec succès." }
        format.turbo_stream # Ajoute une réponse Turbo Stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end


  # Mettre à jour une tâche existante
  def update
    if @task.update(task_params)
      respond_to do |format|
        format.html { redirect_to tasks_path, notice: "Tâche mise à jour avec succès." }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end


  # Supprimer une tâche
  def destroy
    @task.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to tasks_path, notice: "Tâche supprimée avec succès." }
    end
  end



  private

  # Trouver une tâche
  def set_task
    @task = Task.find(params[:id])
  end

  # Paramètres autorisés pour les tâches
  def task_params
    params.require(:task).permit(:title, :description, :completed)
  end
end
