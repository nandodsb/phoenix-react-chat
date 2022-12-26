defmodule PhoenixReactChatWeb.Schema do
  use Absinthe.Schema

  import_types(PhoenixReactChatWeb.Schema.Types)

  alias PhoenixReactChatWeb.Schema.Resolvers

  query do
    @desc "greet"
    field :hello, :string do
      resolve(fn _, _ ->
        {:ok, "world"}
      end)
    end

      @desc "Get all Users"
      field :users, list_of(:user_type) do
        resolve(&Resolvers.UserResolver.get_all_users/3)
      end

      @desc "Get all Rooms"
      field :rooms, list_of(:room_type) do
        resolve(&Resolvers.RoomResolver.get_all_rooms/3)
      end

      @desc "Get all Messages"
      field :messages, list_of(:message_type) do
        arg(:input, non_null(:list_messages_type))
        resolve(&Resolvers.MessageResolver.get_all_messages/3)
      end
    end



    mutation do

      @desc "Create User"
      field :register_user, :boolean do
        arg(:input, non_null(:registration_input_type))
        resolve(&Resolvers.UserResolver.register_user/3)
      end

      @desc "Create Room"
      field :create_room, :boolean do
        arg(:input, non_null(:room_input_type))
        resolve(&Resolvers.RoomResolver.create_room/3)
      end

      @desc "Delete Room"
      field :delete_room, :boolean do
        arg(:input, non_null(:delete_room_input))
        resolve(&Resolvers.RoomResolver.delete_room/3)
      end


      @desc "Create Message"
      field :create_message, :boolean do
        arg(:input, non_null(:message_input_type))
        resolve(&Resolvers.MessageResolver.create_message/3)
      end

      @desc "Delete Message"
      field :delete_message, :boolean do
        arg(:input, non_null(:delete_message_input))
        resolve(&Resolvers.MessageResolver.delete_message/3)
      end
    end
end