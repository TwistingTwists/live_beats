defmodule LiveBeatsWeb.RedirectController do
  use LiveBeatsWeb, :controller

  import LiveBeatsWeb.UserAuth, only: [fetch_current_user: 2]

  @doc """
  ensures that current_user is always present in the conn.assigns

   Who is current user in liveview app ? (even during redirects) More than just :fetch_current_user plug
  """
  plug :fetch_current_user

  def redirect_authenticated(conn, _) do

    # thus conn.assigns.current_user never throws error (because current_user always exists)
    if conn.assigns.current_user do
      LiveBeatsWeb.UserAuth.redirect_if_user_is_authenticated(conn, [])
    else
      redirect(conn, to: Routes.sign_in_path(conn, :index))
    end
  end
end
