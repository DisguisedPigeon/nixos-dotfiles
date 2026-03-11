{
  flake.aspects.chromium.homeManager =
    { pkgs, ... }:
    {
      programs.chromium = {
        enable = true;
        defaultSearchProviderEnabled = false;
        package = pkgs.ungoogled-chromium;
        extensions = [
          { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
          { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark-Reader
          { id = "ldpochfccmkkmhdbclfhpagapcfdljkj"; } # Decentraleyes
          { id = "bkdgflcldnnnapblkhphbgpggdiikppg"; } # DuckDuckGo
          { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # Ublock-Origin
        ];
      };
    };
}
