{
  lib,
  fetchFromGitHub,
  buildGoModule,
  nixosTests,
}:

buildGoModule rec {
  pname = "lego";
  version = "4.23.1-5h";

  src = fetchFromGitHub {
    owner = "ropwareJB";
    repo = "lego";
    tag = "v${version}";
    hash = "sha256-50f14OWAeI/DBBISDHKlSBDrHYxsmphsLFE/quEHAyA=";
  };

  vendorHash = "sha256-L9fjkSrWoP4vs+BlWyEgK+SF3tWQFiEJjd0fJqcruVM=";

  doCheck = false;

  subPackages = [ "cmd/lego" ];

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];

  meta = with lib; {
    description = "Let's Encrypt client and ACME library written in Go";
    license = licenses.mit;
    homepage = "https://go-acme.github.io/lego/";
    teams = [ teams.acme ];
    mainProgram = "lego";
  };

  passthru.tests = {
    lego-http = nixosTests.acme.http01-builtin;
    lego-dns = nixosTests.acme.dns01;
  };
}
