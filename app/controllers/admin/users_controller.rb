module Admin

  # Bankonet on Rails. Copyright (c) 2011 SQLI[www.sqli.com] <br />
  # Author: Philippe Guégan (mailto:pguegan@sqli.com)
  #
  class UsersController < AdminController

    def index
      @users = User.all.paginate :page => params[:page], :per_page => 15
    end

    def show
      @user = User.find(params[:id])
    end
    
    def new
      @user = User.new
    end
    
    def create
      @user = User.new(params[:user])
      # TODO Generate a randomized password, and email it to this user (if save successful)
      # Be that as it may, this logic should be done in the model
      @user.password =  @user.username
      if @user.save
        redirect_to(admin_user_url(@user), :notice => 'Customer was successfully created.')
      else
        render :action => "new"
      end
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update_attributes(params[:user])
        redirect_to(admin_users_url, :notice => 'User was successfully updated.')
      else
        render :action => "edit"
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_url
    end

  end

end
