class PermissionsController < ApplicationController
  # GET /permissions
  # GET /permissions.json
  def index
    @group = Group.find(params[:group_id])
    @permissions = @group.permissions

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @permissions }
    end
  end

  # GET /permissions/1
  # GET /permissions/1.json
  def show
    @permission = Permission.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @permission }
    end
  end

  # GET /permissions/new
  # GET /permissions/new.json
  def new
    @group = Group.find(params[:group_id])
    @permission = @group.permissions.new
    
    @user = User.where(:email => params[:user_email]).first

    respond_to do |format|
      if Permission.where(:group_id => @group.id, :user_id => @user.id).exists?
        format.html { redirect_to(@group, :notice => 'User already exists.') }
        format.json { render json: group_url(@group) }
      elsif @user
        format.html # new.html.erb
        format.json { render json: @permission }
      else
        format.html { redirect_to(@group, :notice => 'User not found.') }
        format.json { render json: group_url(@group) }
      end
    end
  end

  # GET /permissions/1/edit
  def edit
    @permission = Permission.find(params[:id])
  end

  # POST /permissions
  # POST /permissions.json
  def create
    @group = Group.find(params[:group_id])
    @permission = @group.permissions.new(params[:permission])

    respond_to do |format|
      if @permission.save
        format.html { redirect_to group_permission_url(@permission.group, @permission), notice: 'Permission was successfully created.' }
        format.json { render json: @permission, status: :created, location: @permission }
      else
        format.html { render action: "new" }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /permissions/1
  # PUT /permissions/1.json
  def update
    @permission = Permission.find(params[:id])

    respond_to do |format|
      if @permission.update_attributes(params[:permission])
        format.html { redirect_to [@permission.group, @permission], notice: 'Permission was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permissions/1
  # DELETE /permissions/1.json
  def destroy
    @permission = Permission.find(params[:id])
    @permission.destroy

    respond_to do |format|
      format.html { redirect_to group_url(params[:group_id]) }
      format.json { head :no_content }
    end
  end
end
