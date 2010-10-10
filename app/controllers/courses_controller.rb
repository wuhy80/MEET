class CoursesController < ApplicationController
  respond_to :html,:js

  before_filter :select_categories

  def index
  end

  def new
    @course = Course.new()
    @course_category = CourseCategory.find(params[:course_category_id])

    if params[:school_id]
      @school = School.find(params[:school_id])
      @subject = Subject.where("name=?", "Uncategoried").first
    end

    if params[:subject_id]
      @subject = Subject.find(params[:subject_id])
      @school = School.where("name=?", "Uncategoried").first
    end

    @subjects = @course_category.subjects
    @schools = @course_category.schools

    respond_with(@course)
  end

  def show
    @course = Course.find(params[:id])

    respond_with(@course)
  end

  def create
    @course = Course.new(params[:course])
    @course.author = current_user

    if @course.save
      respond_with(@course)
    end
  end

  def edit
    @course = Course.find(params[:id])
    respond_with(@course)	
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(parsms[:course])
      redirect_to :action=>"index", :notice=>"Update Succeed"
    else
      render	:action=>:edit, :notice=>"Update Failed"
    end
  end

  def destroy
    @course = Course.find(params[:id])
    if @course.destroy
      redirect_to	:action=>"index", :notice=>"Destroy Succeed"
    end
  end

  def collect
    @course = Course.find(params[:id])
    current_user.collected_courses << @course

    respond_with(@course)
  end

  def uncollect
    @course = Course.find(params[:id])
    current_user.collected_courses.delete(@course)

    respond_with(@course)
  end

  # 列出某个大类中的所有的Subject以及学校
  def list
    @course_category = CourseCategory.find(params[:id])
    @subjects = @course_category.subjects.roots
    @schools = @course_category.schools
  end

  def show_school
    @school = School.find(params[:id])
    @course_category = CourseCategory.find(params[:course_category_id])
    @courses = @school.courses
    @schools = @course_category.schools
  end

  def show_subject
    @subject = Subject.find(params[:id])
    @course_category = CourseCategory.find(params[:course_category_id])
    @courses = @subject.courses
    @subjects = @course_category.subjects
  end

  def select_categories
    @categories = CourseCategory.all
  end
end

