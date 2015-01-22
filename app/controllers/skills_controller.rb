class SkillsController < ApplicationController
  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skill_params)
    if @skill.save
      # Handle a successful save.
      flash[:success] = "Skill successfully added"
      redirect_to skills_path
    else
      render 'new'
    end
  end

  def update
  end

  def index
    @skills = Skill.all
  end

  def show
  end

  def destroy
  end
end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def skill_params
      params.require(:skill).permit(:name, :link, :image_name, :category, :sub_category)
    end