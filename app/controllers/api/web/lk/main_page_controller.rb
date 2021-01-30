class Api::Web::Lk::MainPageController < Api::Web::Lk::ApplicationController
  #=begin
  # @api {get} /backend/api/web/lk/main_page/content 01 Контент для главной страницы
  # @apiVersion 0.1.0
  # @apiGroup Lk Content
  # @apiPermission Аутентифицированный пользователь
  # @apiHeader {String} auth-token  Authentication Token
  # @apiSampleRequest /backend/api/web/lk/main_page/content
  # @apiSuccessExample {json} Успешный ответ
  # HTTP/1.1 200 OK
  # [{
  #
  # }]
  # @apiError {string} code Результат выполнения запроса.
  # @apiError {string} message Сообщения о ошибках
  # @apiErrorExample {json} Ошибка аутентификации
  # HTTP/1.1 403 Forbidden
  # {"code":"auth_error","message": "Ошибка аутентификации"}
  #=end
  def content
    documents = ActiveModelSerializers::SerializableResource.new(Document.for_main_page.all, each_serializer: DocumentSerializer).as_json
    serialized_events = ActiveModelSerializers::SerializableResource.new(Event.all, each_serializer: EventSerializer).as_json
    working_group_member = ActiveModelSerializers::SerializableResource.new(
      WorkingGroupMember.all.decorate,
      each_serializer: WorkingGroupMemberSerializer
    ).as_json
    events_claims = ActiveModelSerializers::SerializableResource.new(current_user.event_claims, each_serializer: EventClaimSerializer).as_json

    content = {
      documents: documents,
      events: serialized_events,
      working_group_member: working_group_member,
      events_claims: events_claims
    }

    render json: content.as_json
  end
end
