class Web::Admin::EventsController < Web::Admin::ProtectedApplicationController
  def index
    authorize Event
    query = { s: 'id asc' }.merge(params[:q] || {})
    @q = Event.ransack query
    @events = EventDecorator.decorate_collection(@q.result.page(params[:page]).per(params[:per_page]))
    @filter_params = params.permit!.slice(:q, :page, :per_page).to_h
  end

  def new
    @event = Event.new(params[:event])
    authorize @event
  end

  def create
    @event = Event.new(params[:event])
    authorize @event

    if @event.save
      redirect_to admin_events_path
    else
      render action: :new
    end
  end

  def edit
    @event = Event.find(params[:id])

    authorize @event
  end

  def update
    @event = Event.find(params[:id])
    authorize @event

    if @event.update(params[:event])
      redirect_to admin_events_path
    else
      render action: :edit
    end
  end

  def destroy
    event = Event.find(params[:id])
    authorize event
    event.destroy

    redirect_to admin_events_path
  end
end
