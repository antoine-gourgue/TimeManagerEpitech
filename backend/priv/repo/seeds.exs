alias TimeManager.Repo
alias TimeManager.Accounts.{User, Role, Team, UserTeam}
alias TimeManager.Audit.AuditLog
alias TimeManager.Tracking.{Clock, WorkingTime}

# Insérer les rôles
IO.puts("Seeding roles...")
roles = [
  %{name: "admin"},
  %{name: "manager"},
  %{name: "employee"}
]

Enum.each(roles, fn role_attrs ->
  Repo.insert!(Role.changeset(%Role{}, role_attrs))
end)

# Récupérer les rôles après insertion
admin_role = Repo.get_by!(Role, name: "admin")
manager_role = Repo.get_by!(Role, name: "manager")
employee_role = Repo.get_by!(Role, name: "employee")

# Insérer les équipes
IO.puts("Seeding teams...")
teams = [
  %{name: "Development"},
  %{name: "Marketing"},
  %{name: "Sales"}
]

Enum.each(teams, fn team_attrs ->
  Repo.insert!(Team.changeset(%Team{}, team_attrs))
end)

# Récupérer les équipes après insertion
development_team = Repo.get_by!(Team, name: "Development")
marketing_team = Repo.get_by!(Team, name: "Marketing")
sales_team = Repo.get_by!(Team, name: "Sales")

# Insérer les utilisateurs
IO.puts("Seeding users...")
users = [
  %{username: "johndoe", email: "johndoe@example.com", password: "secret", role_id: admin_role.id},
  %{username: "janedoe", email: "janedoe@example.com", password: "secret", role_id: manager_role.id},
  %{username: "alice", email: "alice@example.com", password: "secret", role_id: employee_role.id}
]

Enum.each(users, fn user_attrs ->
  Repo.insert!(User.changeset(%User{}, user_attrs))
end)

# Récupérer les utilisateurs après insertion
johndoe = Repo.get_by!(User, username: "johndoe")
janedoe = Repo.get_by!(User, username: "janedoe")
alice = Repo.get_by!(User, username: "alice")

# Assigner les utilisateurs aux équipes
IO.puts("Assigning users to teams...")
user_teams = [
  %{user_id: johndoe.id, team_id: development_team.id},  # John is in Development
  %{user_id: janedoe.id, team_id: marketing_team.id},   # Jane is in Marketing
  %{user_id: alice.id, team_id: sales_team.id}          # Alice is in Sales
]

Enum.each(user_teams, fn ut_attrs ->
  Repo.insert!(UserTeam.changeset(%UserTeam{}, ut_attrs))
end)

# Insérer les logs d'audit
IO.puts("Seeding audit logs...")
audit_logs = [
  %{table_name: "users", record_id: johndoe.id, action: "create", old_value: %{}, new_value: %{username: "johndoe"}, changed_by: johndoe.id},
  %{table_name: "teams", record_id: development_team.id, action: "create", old_value: %{}, new_value: %{name: "Development"}, changed_by: johndoe.id}
]

Enum.each(audit_logs, fn log_attrs ->
  Repo.insert!(AuditLog.changeset(%AuditLog{}, log_attrs))
end)

# Insérer les horloges
IO.puts("Seeding clocks...")
clocks = [
  %{status: "IN", time: ~N[2024-10-14 09:00:00], user_id: johndoe.id},
  %{status: "OUT", time: ~N[2024-10-14 17:00:00], user_id: johndoe.id},
  %{status: "IN", time: ~N[2024-10-14 09:00:00], user_id: janedoe.id},
  %{status: "OUT", time: ~N[2024-10-14 17:00:00], user_id: janedoe.id}
]

Enum.each(clocks, fn clock_attrs ->
  Repo.insert!(Clock.changeset(%Clock{}, clock_attrs))
end)

# Insérer les heures de travail
IO.puts("Seeding working times...")
working_times = [
  %{type: "work", start_time: ~N[2024-10-14 09:00:00], end_time: ~N[2024-10-14 17:00:00], user_id: johndoe.id},
  %{type: "break", start_time: ~N[2024-10-14 12:00:00], end_time: ~N[2024-10-14 12:30:00], user_id: johndoe.id},
  %{type: "work", start_time: ~N[2024-10-14 09:00:00], end_time: ~N[2024-10-14 17:00:00], user_id: janedoe.id}
]

Enum.each(working_times, fn wt_attrs ->
  Repo.insert!(WorkingTime.changeset(%WorkingTime{}, wt_attrs))
end)

IO.puts("Seeding complete!")
