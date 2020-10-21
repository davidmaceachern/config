{config, pkgs, ...}:
{

# services.nginx = {
#   enable = true;
#    recommendedGzipSettings = true;
#    recommendedOptimisation = true;
#    recommendedProxySettings = true;
#    recommendedTlsSettings = true;

#    sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";
#    virtualHosts = {
#       "100.71.22.20" = {
         ## Force HTTP redirect to HTTPS
#         forceSSL = true;
         ## LetsEncrypt
         ## enableACME = true;
#      };
#    };
#  };

  # TODO services.nextcloud.home #   Default: "/var/lib/nextcloud"
  # TODO services.nextcloud.config.extraTrustedDomains ['ip one']

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud19;
    hostName = "127.0.0.1";
    nginx.enable = true;
    https = true;
    autoUpdateApps.enable = true;
    autoUpdateApps.startAt = "05:00:00";
    config = {
      #overwriteProtocol = "https";
      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql";
      dbname = "nextcloud";
      dbpassFile = "/var/nextcloud-db-pass";
      adminpassFile = "/var/nextcloud-admin-pass";
      adminuser = "admin";
 };
};

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [
     { name = "nextcloud";
       ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
     }
    ];
};
  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
};
}
