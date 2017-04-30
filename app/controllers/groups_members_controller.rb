class GroupsMembersController < ApplicationController

  def create
    @groups_member = Groups_member.new(groups_member_params)
    @groups_member.save
    flash[:success] = "Successfully added to the classroom"
    redirect_to 'users/show'
  end

  private

  def groups_member_params
    params.require(:groups_member).permit(:user_id, :group_id)
  end

end
