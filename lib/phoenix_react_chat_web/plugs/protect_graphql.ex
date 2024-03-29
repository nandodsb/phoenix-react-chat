defmodule PhoenixReactChatWeb.Plugs.ProtectGraphql do

  import Plug.Conn

  alias PhoenixReactChat.Auth
  alias PhoenixReactChat.Auth.User
  alias PhoenixReactChatWeb.Constants

  def init(_params) do
  end

  def call(conn, _params) do

    user_id = Plug.Conn.get_session(conn, :current_user_id)

    if user_id do
      user = Auth.get_user!(user_id)

      case user do
        %User{} ->
          conn
          |> Absinthe.Plug.put_options(context: %{current_user: user})

          _ ->
            send_resp(conn, 401, Constants.not_authenticated())
            conn
            |> halt()
      end
    else
      send_resp(conn, 401, Constants.not_authenticated())
            conn
            |> halt()
    end
  end
end
