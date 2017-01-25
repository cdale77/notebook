defmodule Notebook.Api.V1.SessionView do
  use Notebook.Web, :view

  def render("show.json", %{user: user, jwt: jwt}) do
    %{user: user, jwt: jwt}
  end

  def render("delete.json", %{message: message}) do
    %{message: message}
  end

  def render("error.json", %{message: message}) do
    %{message: message}
  end
end
