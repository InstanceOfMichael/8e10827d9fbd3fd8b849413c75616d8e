database_name = "lpbb_#{Lucky::Env.name}"

AppDatabase.configure do |settings|
  if Lucky::Env.production?
    settings.url = ENV.fetch("DATABASE_URL")
  else
    settings.url = ENV["DATABASE_URL"]? || Avram::PostgresURL.build(
      database: database_name,
      hostname: ENV["DB_HOST"]? || "localhost",
      # Some common usernames are "postgres", "root", or your system username (run 'whoami')
      username: ENV["DB_USERNAME"]? || "postgres",
      # Some Postgres installations require no password. Use "" if that is the case.
      password: ENV["DB_PASSWORD"]? || "postgres"
    )
  end
end

Avram.configure do |settings|
  settings.database_to_migrate = AppDatabase

  # In production, allow lazy loading (N+1).
  # In development and test, raise an error if you forget to preload associations
  settings.lazy_load_enabled = Lucky::Env.production?
  
  # Uncomment the next line to log all SQL queries
  # settings.query_log_level = ::Logger::Severity::DEBUG
end

# sudo -u postgres psql -p 5433
# CREATE USER lpbb with encrypted password 'lpbb'; CREATE DATABASE lpbb; GRANT ALL PRIVILEGES ON DATABASE lpbb to lpbb; CREATE DATABASE lpbb_testing; GRANT ALL PRIVILEGES ON DATABASE lpbb_testing to lpbb;
