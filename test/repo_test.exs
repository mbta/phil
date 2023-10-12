defmodule Phil.RepoTest do
  use ExUnit.Case, async: false

  alias Phil.Repo

  describe "configure_production_connection/1" do
    setup do
      original_hostname = System.get_env("DATABASE_HOST")
      original_username = System.get_env("DATABASE_USER")
      original_database = System.get_env("DATABASE_NAME")
      original_port = System.get_env("DATABASE_PORT")

      System.put_env("DATABASE_HOST", "test_db_server_hostname")
      System.put_env("DATABASE_USER", "test_username")
      System.put_env("DATABASE_NAME", "test_database")
      System.put_env("DATABASE_PORT", "6789")

      on_exit(fn ->
        if original_hostname do
          System.put_env("DATABASE_HOST", original_hostname)
        else
          System.delete_env("DATABASE_HOST")
        end

        if original_username do
          System.put_env("DATABASE_USER", original_username)
        else
          System.delete_env("DATABASE_USER")
        end

        if original_database do
          System.put_env("DATABASE_NAME", original_database)
        else
          System.delete_env("DATABASE_NAME")
        end

        if original_port do
          System.put_env("DATABASE_PORT", original_port)
        else
          System.delete_env("DATABASE_PORT")
        end
      end)

      :ok
    end

    test "generates RDS IAM auth token" do
      mock_auth_token_fn = fn "test_db_server_hostname", "test_username", 6789, %{} ->
        "test_iam_token"
      end

      input_config = [
        username: nil,
        password: nil,
        hostname: nil,
        port: 5432,
        ssl: true
      ]

      expected_output = [
        database: "test_database",
        username: "test_username",
        password: "test_iam_token",
        hostname: "test_db_server_hostname",
        port: 6789,
        socket_options: [],
        ssl: true,
        ssl_opts: [
          cacertfile: "priv/aws-cert-bundle.pem",
          verify: :verify_peer,
          server_name_indication: ~c"test_db_server_hostname",
          verify_fun:
            {&:ssl_verify_hostname.verify_fun/3, [check_hostname: ~c"test_db_server_hostname"]}
        ]
      ]

      assert Repo.configure_production_connection(input_config, mock_auth_token_fn) |> Enum.sort() ==
               expected_output |> Enum.sort()
    end
  end
end
