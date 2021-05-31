class Metriql < Formula
  desc "Metrics layer"
  homepage "https://metriql.com"
  url "https://storage.googleapis.com/cdn.rakam.io/metriql/target/metriql-0.4-SNAPSHOT-bundle.tar.gz"
  sha256 "f56cfbb2b3f3b750d94d060026f4de4bb675f707b7cb398f23fa603651dcccfe"
  license "Apache License"

  # depends_on "cmake" => :build
  depends_on "java"


  def install
    bin.install_symlink "#{libexec}/bin/metriql" => "bin/metriql"
  end

  test do
    (testpath/"dbt_project.yml").write(
      "{name: 'test', version: '0.0.1', config-version: 2, profile: 'default'}",
    )
    (testpath/".dbt/profiles.yml").write(
      "{default: {outputs: {default: {type: 'postgres',
      threads: 1, host: 'localhost', port: 5432, user: 'root',
      pass: 'password', dbname: 'test', schema: 'test'}},
      target: 'default'}}",
    )
    (testpath/"models/test.sql").write("select * from test")
    system "#{bin}/dbt", "test"
  end
end
