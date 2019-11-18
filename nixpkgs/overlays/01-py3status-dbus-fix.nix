#
# Overlay fixes py3status until I get my PR in the upstream
# distribution
#
self: super: {
  python37Packages = super.python37Packages.override {
    overrides = self: super: {
      py3status = super.py3status.overrideAttrs(oldAttrs: {
        propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ super.dbus-python ];
      });
    };
  };
}
