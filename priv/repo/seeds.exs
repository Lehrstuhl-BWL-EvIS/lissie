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
  user_email = "max@uni-beispiel.de"
  user_password = "Password1234!"

  user =
    case Accounts.get_user_by_email(user_email) do
      nil ->
        {:ok, user} =
          Accounts.register_user(%{
            email: user_email,
            password: user_password
          })

        IO.puts("Created user: #{user_email}")
        user

      user ->
        IO.puts("User already exists: #{user_email}")
        user
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

    IO.puts("✅ Created student #{student_id} for user #{user.email}")
  end
end
