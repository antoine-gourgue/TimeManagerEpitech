defmodule TimeManager.TrackingTest do
  use TimeManager.DataCase

  alias TimeManager.Tracking

  describe "working_times" do
    alias TimeManager.Tracking.WorkingTime

    import TimeManager.TrackingFixtures
    import TimeManager.AccountsFixtures

    @invalid_attrs %{type: nil, start_time: nil, end_time: nil, user_id: nil}

    test "list_working_times/0 returns all working_times" do
      working_time = working_time_fixture()
      assert Tracking.list_working_times() == [working_time]
    end

    test "get_working_time!/1 returns the working_time with given id" do
      working_time = working_time_fixture()
      assert Tracking.get_working_time!(working_time.id) == working_time
    end

    test "create_working_time/1 with valid data creates a working_time" do
      user = user_fixture()
      valid_attrs = %{type: "some type", start_time: ~N[2024-10-13 12:16:00], end_time: ~N[2024-10-13 12:16:00], user_id: user.id}

      assert {:ok, %WorkingTime{} = working_time} = Tracking.create_working_time(valid_attrs)
      assert working_time.type == "some type"
      assert working_time.start_time == ~N[2024-10-13 12:16:00]
      assert working_time.end_time == ~N[2024-10-13 12:16:00]
      assert working_time.user_id == user.id
    end

    test "create_working_time/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracking.create_working_time(@invalid_attrs)
    end

    test "update_working_time/2 with valid data updates the working_time" do
      working_time = working_time_fixture()
      update_attrs = %{type: "some updated type", start_time: ~N[2024-10-14 12:16:00], end_time: ~N[2024-10-14 12:16:00]}

      assert {:ok, %WorkingTime{} = working_time} = Tracking.update_working_time(working_time, update_attrs)
      assert working_time.type == "some updated type"
      assert working_time.start_time == ~N[2024-10-14 12:16:00]
      assert working_time.end_time == ~N[2024-10-14 12:16:00]
    end

    test "update_working_time/2 with invalid data returns error changeset" do
      working_time = working_time_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracking.update_working_time(working_time, @invalid_attrs)
      assert working_time == Tracking.get_working_time!(working_time.id)
    end

    test "delete_working_time/1 deletes the working_time" do
      working_time = working_time_fixture()
      assert {:ok, %WorkingTime{}} = Tracking.delete_working_time(working_time)
      assert_raise Ecto.NoResultsError, fn -> Tracking.get_working_time!(working_time.id) end
    end

    test "change_working_time/1 returns a working_time changeset" do
      working_time = working_time_fixture()
      assert %Ecto.Changeset{} = Tracking.change_working_time(working_time)
    end
  end

  describe "clocks" do
    alias TimeManager.Tracking.Clock

    import TimeManager.TrackingFixtures
    import TimeManager.AccountsFixtures

    @invalid_attrs %{status: nil, time: nil, user_id: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert Tracking.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert Tracking.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      user = user_fixture()
      valid_attrs = %{status: "some status", time: ~N[2024-10-13 12:17:00], user_id: user.id}

      assert {:ok, %Clock{} = clock} = Tracking.create_clock(valid_attrs)
      assert clock.status == "some status"
      assert clock.time == ~N[2024-10-13 12:17:00]
      assert clock.user_id == user.id
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracking.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: "some updated status", time: ~N[2024-10-14 12:17:00]}

      assert {:ok, %Clock{} = clock} = Tracking.update_clock(clock, update_attrs)
      assert clock.status == "some updated status"
      assert clock.time == ~N[2024-10-14 12:17:00]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracking.update_clock(clock, @invalid_attrs)
      assert clock == Tracking.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = Tracking.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Tracking.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = Tracking.change_clock(clock)
    end
  end
end
