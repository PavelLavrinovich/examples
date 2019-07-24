class ArchiveController < ApplicationController
  unloadable
  accept_api_auth :index, :show

  def index
    query = Project.visible.map { |project| "project_id = #{project.id}" }.join(" or ")

    if query != ''
  	  @archive = params[:last_change_id] ? Archive.where("id > ? and (#{query})", params[:last_change_id]) : Archive.where(query)
    end
    @archive ||= []
    
    respond_to do |format|
      format.html 
      format.xml { render xml: @archive }
      format.json { render json: { archives: @archive.as_json(root: false) } } 
    end     	
  end

  def show
    @archive_line = Archive.find(params[:archive_id])
    raise ::Unauthorized unless Project.find( @archive_line.project_id ).visible?

    respond_to do |format|
      format.html 
      format.xml { render xml: @archive_line }
      format.json { render json: @archive_line.as_json(root: true) } 
    end
  end
end
