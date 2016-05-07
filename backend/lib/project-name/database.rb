require 'project-name/config'
require 'sequel'

$db = Sequel.connect(
  "postgres://#{$conf['db/username']}@#{$conf['db/host']}/#{$conf['db/database']}",
  max_connections: $conf['db/num_connections']
)

module ProjectName
  module Database
    def self.tables
      $db.fetch(%{
        SELECT table_name
        FROM information_schema.tables
        WHERE
          table_schema = 'public'
          AND table_name NOT IN (
            'schema_migrations'
          )
      }).map { |row|
        row[:table_name]
      }
    end
  end
end

ProjectName::Database.tables.each do |table|
  $db.run(%{
    CREATE OR REPLACE FUNCTION after_update_on_#{table}() RETURNS trigger AS $$
    DECLARE
    BEGIN
        PERFORM pg_notify('#{table}_update', NEW.id::TEXT );
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql
  })

  begin
    $db.run(%{
      CREATE TRIGGER trigger_after_update_on_#{table}
      AFTER UPDATE ON #{table}
      FOR EACH ROW
      EXECUTE PROCEDURE after_update_on_#{table}()
    })
  rescue Sequel::DatabaseError => e
    raise e  if e.message !~ /PG::DuplicateObject/
  end

  $db.run(%{
    CREATE OR REPLACE FUNCTION after_insert_on_#{table}() RETURNS trigger AS $$
    DECLARE
    BEGIN
        PERFORM pg_notify('#{table}_insert', NEW.id::TEXT );
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql
  })

  begin
    $db.run(%{
      CREATE TRIGGER trigger_after_insert_on_#{table}
      AFTER INSERT ON #{table}
      FOR EACH ROW
      EXECUTE PROCEDURE after_insert_on_#{table}()
    })
  rescue Sequel::DatabaseError => e
    raise e  if e.message !~ /PG::DuplicateObject/
  end

  $db.run(%{
    CREATE OR REPLACE FUNCTION after_delete_on_#{table}() RETURNS trigger AS $$
    DECLARE
    BEGIN
        PERFORM pg_notify('#{table}_delete', OLD.id::TEXT );
        RETURN OLD;
    END;
    $$ LANGUAGE plpgsql
  })

  begin
    $db.run(%{
      CREATE TRIGGER trigger_after_delete_on_#{table}
      AFTER DELETE ON #{table}
      FOR EACH ROW
      EXECUTE PROCEDURE after_delete_on_#{table}()
    })
  rescue Sequel::DatabaseError => e
    raise e  if e.message !~ /PG::DuplicateObject/
  end
end
