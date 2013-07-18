class GroupController < ApplicationController
  def index
    @groups = current_user.groups.all
  end
  def show
    @group = Group.find(params[:id])
  end

  def create   
    group = Group.create()
    group.name = params[:group]['name']
    group.users << current_user
    group.save

  end

  def assign_to_group
    puts '**************************'
    to_group = Group.find(params[:group]['group_id'])
    puts to_group.name
    puts params[:group]['article_id']

    puts to_group.articles << Article.find(params[:group]['article_id'])
  end

  def new
  end

end