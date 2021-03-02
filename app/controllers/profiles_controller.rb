class ProfilesController < ApplicationController
  def show
    @profile = Profile.find_by(id: params[:id])
  end

  def edit
    @profile = Profile.find_by(id: params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      flash[:notice] = 'Profile updated!!!'
      redirect_to @profile
    else
      render 'edit'
    end
  end

  def profile_params
    params.require(:profile).permit(:name, :image)
  end
end
