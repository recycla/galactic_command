defmodule GalacticCommandWeb.MissionLiveTest do
  use GalacticCommandWeb.ConnCase

  import Phoenix.LiveViewTest
  import GalacticCommand.MissionsFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_mission(_) do
    mission = mission_fixture()
    %{mission: mission}
  end

  describe "Index" do
    setup [:create_mission]

    test "lists all missions", %{conn: conn, mission: mission} do
      {:ok, _index_live, html} = live(conn, ~p"/missions")

      assert html =~ "Listing Missions"
      assert html =~ mission.name
    end

    test "saves new mission", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/missions")

      assert index_live |> element("a", "New Mission") |> render_click() =~
               "New Mission"

      assert_patch(index_live, ~p"/missions/new")

      assert index_live
             |> form("#mission-form", mission: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#mission-form", mission: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/missions")

      html = render(index_live)
      assert html =~ "Mission created successfully"
      assert html =~ "some name"
    end

    test "updates mission in listing", %{conn: conn, mission: mission} do
      {:ok, index_live, _html} = live(conn, ~p"/missions")

      assert index_live |> element("#missions-#{mission.id} a", "Edit") |> render_click() =~
               "Edit Mission"

      assert_patch(index_live, ~p"/missions/#{mission}/edit")

      assert index_live
             |> form("#mission-form", mission: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#mission-form", mission: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/missions")

      html = render(index_live)
      assert html =~ "Mission updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes mission in listing", %{conn: conn, mission: mission} do
      {:ok, index_live, _html} = live(conn, ~p"/missions")

      assert index_live |> element("#missions-#{mission.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#missions-#{mission.id}")
    end
  end

  describe "Show" do
    setup [:create_mission]

    test "displays mission", %{conn: conn, mission: mission} do
      {:ok, _show_live, html} = live(conn, ~p"/missions/#{mission}")

      assert html =~ "Show Mission"
      assert html =~ mission.name
    end

    test "updates mission within modal", %{conn: conn, mission: mission} do
      {:ok, show_live, _html} = live(conn, ~p"/missions/#{mission}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Mission"

      assert_patch(show_live, ~p"/missions/#{mission}/show/edit")

      assert show_live
             |> form("#mission-form", mission: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#mission-form", mission: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/missions/#{mission}")

      html = render(show_live)
      assert html =~ "Mission updated successfully"
      assert html =~ "some updated name"
    end
  end
end
