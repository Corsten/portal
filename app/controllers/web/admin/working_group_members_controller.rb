class Web::Admin::WorkingGroupMembersController < Web::Admin::ProtectedApplicationController
  def index
    authorize WorkingGroupMember
    query = { s: 'id asc' }.merge(params[:q] || {})
    @q = WorkingGroupMember.ransack query
    @group_members = @q.result.page(params[:page]).per(params[:per_page]).decorate
    @filter_params = params.permit!.slice(:q, :page, :per_page).to_h
  end

  def new
    @group_member = WorkingGroupMember.new(params[:working_group_member])
    authorize @group_member
  end

  def create
    @group_member = WorkingGroupMember.new(params[:working_group_member])
    authorize @group_member

    if @group_member.save
      redirect_to admin_working_group_members_path
    else
      render action: :new
    end
  end

  def edit
    @group_member = WorkingGroupMember.find(params[:id])
    authorize @group_member
  end

  def update
    @group_member = WorkingGroupMember.find(params[:id])
    authorize @group_member

    if @group_member.update(params[:working_group_member])
      redirect_to admin_working_group_members_path
    else
      render action: :edit
    end
  end

  def destroy
    member = WorkingGroupMember.find(params[:id])
    authorize member
    member.destroy

    redirect_to admin_working_group_membres_path
  end
end
