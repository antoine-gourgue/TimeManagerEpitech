alias TimeManager.Repo
alias TimeManager.Accounts.{User, Role, Team, UserTeam}
alias TimeManager.Audit.AuditLog
alias TimeManager.Tracking.{Clock, WorkingTime}

# Insert Roles
IO.puts("Seeding roles...")
roles = [
  %{name: "admin"},
  %{name: "manager"},
  %{name: "employee"}
]

Enum.each(roles, fn role_attrs ->
  Repo.insert!(Role.changeset(%Role{}, role_attrs))
end)

# Insert Teams
IO.puts("Seeding teams...")
teams = [
  %{name: "Development"},
  %{name: "Marketing"},
  %{name: "Sales"}
]

Enum.each(teams, fn team_attrs ->
  Repo.insert!(Team.changeset(%Team{}, team_attrs))
end)

# Retrieve role IDs for insertion
admin_role = Repo.get_by!(Role, name: "admin")
manager_role = Repo.get_by!(Role, name: "manager")
employee_role = Repo.get_by!(Role, name: "employee")

# Insert Users
IO.puts("Seeding users...")
users = [
  %{username: "johndoe", email: "johndoe@example.com", password: "secret", role_id: admin_role.id},
  %{username: "janedoe", email: "janedoe@example.com", password: "secret", role_id: manager_role.id},
  %{username: "alice", email: "alice@example.com", password: "secret", role_id: employee_role.id}
]

Enum.each(users, fn user_attrs ->
  Repo.insert!(User.changeset(%User{}, user_attrs))
end)

# Assign users to teams
IO.puts("Assigning users to teams...")
user_teams = [
  %{user_id: 1, team_id: 1},  # John is in Development
  %{user_id: 2, team_id: 2},  # Jane is in Marketing
  %{user_id: 3, team_id: 3}   # Alice is in Sales
]

Enum.each(user_teams, fn ut_attrs ->
  Repo.insert!(UserTeam.changeset(%UserTeam{}, ut_attrs))
end)

# Insert audit logs
IO.puts("Seeding audit logs...")
audit_logs = [
  %{table_name: "users", record_id: 1, action: "create", old_value: %{}, new_value: %{username: "johndoe"}, changed_by: 1},
  %{table_name: "teams", record_id: 1, action: "create", old_value: %{}, new_value: %{name: "Development"}, changed_by: 1}
]

Enum.each(audit_logs, fn log_attrs ->
  Repo.insert!(AuditLog.changeset(%AuditLog{}, log_attrs))
end)

# Insert clocks
IO.puts("Seeding clocks...")
clocks = [
  %{status: "IN", time: ~N[2024-10-14 09:00:00], user_id: 1},
  %{status: "OUT", time: ~N[2024-10-14 17:00:00], user_id: 1},
  %{status: "IN", time: ~N[2024-10-14 09:00:00], user_id: 2},
  %{status: "OUT", time: ~N[2024-10-14 17:00:00], user_id: 2}
]

Enum.each(clocks, fn clock_attrs ->
  Repo.insert!(Clock.changeset(%Clock{}, clock_attrs))
end)

# Insert working times
IO.puts("Seeding working times...")
working_times = [
  %{type: "work", start_time: ~N[2024-10-14 09:00:00], end_time: ~N[2024-10-14 17:00:00], user_id: 1},
  %{type: "break", start_time: ~N[2024-10-14 12:00:00], end_time: ~N[2024-10-14 12:30:00], user_id: 1},
  %{type: "work", start_time: ~N[2024-10-14 09:00:00], end_time: ~N[2024-10-14 17:00:00], user_id: 2}
]

Enum.each(working_times, fn wt_attrs ->
  Repo.insert!(WorkingTime.changeset(%WorkingTime{}, wt_attrs))
end)

IO.puts("Seeding complete!")
