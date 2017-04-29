class GroupsMembersController < ApplicationController

  def create
    @Member = Groups_member.new(groups_member_params)
    @Member.save
    flash[:success] = "Successfully added to the classroom"
    redirect_to 'users/show'
  end

  private

  def groups_member_params
    params.require(:groups_member).permit(:user_id, :group_id)
  end

end
