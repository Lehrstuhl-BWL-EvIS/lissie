# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Lissie.Repo.insert!(%Lissie.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Lissie.Repo
alias Lissie.Accounts
# alias Lissie.Accounts.User
# alias Lissie.Accounts.Scope
alias Lissie.Students
alias Lissie.Students.Student

###################################
# Add Users
# Only in the dev environment!

if Mix.env() in [:dev] do
  # 1. Create or get user
  user_attrs = %{
    email: "test@test.de",
    password: "password1234",
    password_confirmation: "password1234"
  }

  # Check if the user already exists
  case Accounts.get_user_by_email(user_attrs.email) do
    nil ->
      {:ok, _user} = Accounts.register_user(user_attrs)
      IO.puts("Seed user created: #{user_attrs.email}")

    _user ->
      IO.puts("Seed user already exists: #{user_attrs.email}")
  end

  # 2. Create or get student for the user
  student_id = "S-4711"
  firstname = "Jane"
  lastname = "Student"

  # You may need to implement this helper in your Students context
  student = Repo.get_by(Student, student_id: student_id)

  if student do
    IO.puts("ℹ️ Student already exists: #{student_id}")
  else
    {:ok, student} =
      Students.create_student(%{
        student_id: student_id,
        firstname: firstname,
        lastname: lastname
      })

    IO.puts("✅ Created student #{student_id}")
  end
end
