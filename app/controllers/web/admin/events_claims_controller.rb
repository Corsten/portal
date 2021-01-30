class Web::Admin::EventsClaimsController < Web::Admin::ProtectedApplicationController
  def index
    authorize Event::Claim
    query = { s: 'id asc' }.merge(params[:q] || {})

    @q = Event::Claim.ransack query

    @events_claims = @q.result.page(params[:page]).per(params[:per_page])
    @filter_params = params.permit!.slice(:q, :page, :per_page).to_h
  end

  def edit
    @event_claim = Event::Claim.find(params[:id])
    authorize @event_claim
  end

  def block
    claim = Event::Claim.find(params[:id])
    authorize claim
    claim.block!

    flash[:success] = t('flashes.event.claim.block', id: claim.id)

    redirect_back(fallback_location: admin_events_claims_path)
  end

  def unblock
    claim = Event::Claim.active.find(params[:id])
    authorize claim
    claim.unblock!

    flash[:success] = t('flashes.event.claim.unblock', id: claim.id)

    redirect_back(fallback_location: admin_events_claims_path)
  end
end
